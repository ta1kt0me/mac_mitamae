include_recipe 'directory_helper'

bin_path = DirectoryHelper.local_bin_path(node)

execute "Install eget" do
  user node[:user]
  command "curl https://zyedidia.github.io/eget.sh | sh && mv eget #{bin_path}/"
  not_if "test -x #{bin_path}/eget"
end

node[:gh_repos].each do |gh_repo|
  bin = gh_repo[:bin] || gh_repo[:repo].split('/').last
  execute "Install #{gh_repo[:repo]} via eget" do
    user node[:user]
    command "#{bin_path}/eget --upgrade-only #{gh_repo[:repo]} --to #{bin_path}/#{bin}"
  end
end
