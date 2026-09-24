include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)
node[:git].each do |item|
  git "#{home_path}/#{item[:dist]}" do
    user node[:user]
    repository item[:repo]
  end
end
