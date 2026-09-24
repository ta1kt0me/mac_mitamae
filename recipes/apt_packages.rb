include_recipe 'platform_helper'

if node[:platform] == "pop"
  node[:apt_packages].each do |item|
    user "root"
    package item
  end
end
