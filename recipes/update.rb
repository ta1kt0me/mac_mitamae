# Update tools to the latest. Run by bin/update, not by init.rb.

include_recipe 'directory_helper'

bin_path = DirectoryHelper.local_bin_path(node)
mise = "#{bin_path}/mise"

node[:mise][:plugins].each do |plugin|
  execute "Update #{plugin} plugin via mise" do
    user node[:user]
    command "#{mise} plugins update #{plugin}"
  end
end

latest_tools = node[:mise][:packages].select { |package| package.end_with?("@latest") } +
  node[:mise][:plugins].map { |plugin| "#{plugin}@latest" }

latest_tools.each do |tool|
  execute "Update #{tool} via mise" do
    user node[:user]
    command "#{mise} use --global #{tool}"
  end
end

node[:gh_repos].each do |gh_repo|
  bin = gh_repo[:bin] || gh_repo[:repo].split('/').last
  execute "Update #{gh_repo[:repo]} via eget" do
    user node[:user]
    command "#{bin_path}/eget --upgrade-only #{gh_repo[:repo]} --to #{bin_path}/#{bin}"
  end
end

execute "Update vim's plugin" do
  user node[:user]
  command "vim -c 'PlugUpdate|q!|q!'"
end
