node[:packages].each do |item|
  package item
end

if node[:platform] == "darwin"
  node[:homebrew_packages].each do |item|
    package item
  end
end

if node[:platform] == "ubuntu"
  node[:apt_packages].each do |item|
    package item
  end
end
