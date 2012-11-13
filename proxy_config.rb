# Set :preserve_host to true globally (default is true already)
 reverse_proxy_options :preserve_host => false
 keep_headers ["X-AUTH"]
 # Forward the path /* to 'http://localhost:3002/*'
 reverse_proxy '/', 'http://localhost:3002',{ extra_headers: {"X_AUTH"=> lambda{|env| env['warden'].user.to_json}}}
