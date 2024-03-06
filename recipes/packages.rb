node[:packages].each do |item|
  package item
end

if node[:platform] == "darwin"
  node[:homebrew_packages].each do |item|
    package item
  end
end
