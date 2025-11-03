node[:packages].each do |item|
  package item
end

node[:homebrew_packages].each do |item|
  package item
end
