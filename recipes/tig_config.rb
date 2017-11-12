node[:tig_config][:set].each do |config|
  execute "Set tig config `set #{config}`" do
    command "echo 'set #{config}' >> $HOME/.tigrc"
    not_if "test $(grep 'set #{config}' $HOME/.tigrc | wc -l | xargs) -gt 0"
  end
end

node[:tig_config][:bind].each do |config|
  conf = "bind #{config.view} #{config.keybind} #{config.value}"
  execute "Set tig config `#{conf}`" do
    command "echo '#{conf}' >> $HOME/.tigrc"
    not_if "test $(grep '#{conf}' $HOME/.tigrc | wc -l | xargs) -gt 0"
  end
end

# node[:tig_config].each do |conf|
#   p conf
#   conf[:set].each do |conf_set|
#     p '---'
#     p conf_set
#   end
#   conf[:bind].each do |conf_bind|
#     puts conf_bind
#   end
#   # k = config[:key]
#   # v = config[:value]
#   # execute "Set git config #{k}" do
#   #   command "git config --global --replace-all #{k} \"#{v}\""
#   #   not_if "test $(git config --global --get #{k}) -eq \"#{v}\""
#   # end
# end
