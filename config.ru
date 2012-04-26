require 'rack/reverse_proxy'
require 'omniauth/builder'
require 'omniauth_openid_connect'
require 'rack/session/cookie'
require 'pry'
require 'warden'
require 'warden_omniauth'
require 'yaml'

Warden::Manager.serialize_into_session do |user|
  user
end

Warden::Manager.serialize_from_session do |user|
  user
end

app = lambda do |e|
  
  request = Rack::Request.new(e)
  if request.path =~ /logout/
    e['warden'].logout
    r = Rack::Response.new
    r.redirect("/")
    r.finish
  else
    e['warden'].authenticate!
   
    Rack::Response.new(e['warden'].user.inspect).finish
  end
end

failure = lambda{|e| Rack::Resposne.new("Can't login", 401).finish }



use Rack::Session::Cookie

use Warden::Manager do |config|
  config.failure_app = failure
  config.default_strategies :omni_openid_connect
end


module Rack
  class ReverseProxy
    alias :old_call :call
    def call(env)
     
      return @app.call(env) unless (env['warden'] && env['warden'].authenticated?)
      old_call(env)
    end
     
  end
end

use Rack::ReverseProxy do 
  instance_eval  File.new('proxy_config.rb').read
 
end


use OmniAuth::Builder do

  config = YAML.load(File.new("openid.yml"))
  provider :openid_connect , config['host'], config['client_id'], config['client_secret'],config['additional_properties']
                                                                    
end



use WardenOmniAuth do |config|
  #config.redirect_after_callback = "/redirect/path" # default "/"
end

WardenOmniAuth.setup_strategies("openid_connect")

WardenOmniAuth.on_callback do |omni_user|
omni_user
end


run app