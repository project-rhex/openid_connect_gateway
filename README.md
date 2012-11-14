Openid Connect Gateway
=======================

The OpenID Connect Gateway is a simple proxy application that will authenticate users
via OpenID Connect before proxying the request to a different host.  As part of the
proxy configuration additional information pertaining to the authenticated user can
be set in the request headers to the proxied service.  

Installation
------------

Clone the git repository and run bundle install


Configuration 
----------------

There are sample openid.yml files in the doc/ directory.

OpenID Connect idP configuration 

openid.yml file

host: the idp host name

client_id: the client id for the idp

client_secret:  the clients idp secret

additional_properties:   --- These properties override default values 

  authorization_endpoint:  the idp authroization endpoint
  
  user_info_endpoint: the idp user_info endpoint
  
  token_endpoint:  the idp token endpoint
  
  check_id_endpoint: the idp check_id_ endpoint
  
  issuer: the issuer info that will come back in the id_token_
  
  client_options:  -- some additional options for the client connection to the idp
  
    scheme:  the scheme in use at the idp   http, https
    
    port:  the port that the idp is running on


proxy_config.rb

see https://github.com/project-rhex/rack-reverse-proxy for configurating proxy rules


Running 
--------


bundle exec rackup 


License
-------

Copyright 2012 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.