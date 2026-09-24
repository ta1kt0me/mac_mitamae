include_recipe 'directory_helper'

lines = node[:tig_config][:set].map { |config| "set #{config}" } +
  node[:tig_config][:bind].map { |config| "bind #{config[:view]} #{config[:keybind]} #{config[:value]}" }

file "#{DirectoryHelper.home_path(node)}/.tigrc" do
  user node[:user]
  content lines.join("\n") + "\n"
end
