include_recipe 'packages'

node[:homebrew_packages].each do |item|
  package item
end
