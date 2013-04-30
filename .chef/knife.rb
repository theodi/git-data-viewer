current_dir = File.dirname(__FILE__)

log_level               :debug
log_location            STDOUT
node_name               "odi"
client_key              "#{current_dir}/odi.pem"
validation_client_name  "chef-validator"
validation_key          "#{current_dir}/chef-validator.pem"
chef_server_url         "https://chef.theodi.org"
cache_type              "BasicFile"
cookbook_path           [
                          '#{current_dir}/../cookbooks',
                          '#{current_dir}/../site-cookbooks'
                        ]

cache_options(:path => "#{current_dir}/checksums")

cookbook_copyright "The Open Data Institute"
cookbook_license "mit"
cookbook_email "tech@theodi.org"
readme_format "md"
