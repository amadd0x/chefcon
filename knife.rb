current_dir = File.dirname(__FILE__)
log_level                :debug
log_location             STDOUT
node_name                "#{ENV['KNIFE_NODE_NAME']}"
client_key               "#{ENV['KNIFE_CLIENT_KEY']}"
chef_server_url           "#{ENV['KNIFE_CHEF_SERVER_URL']}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{ENV['HOME']}/workspace"]
knife[:editor] =         "/usr/bin/vim.tiny"
ssl_verify_mode    :verify_none