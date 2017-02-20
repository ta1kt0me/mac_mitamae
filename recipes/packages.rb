node[:packages].each do |item|
  package item
end

node[:packages_with_option].each do |item|
  package item[:name] do
    options item[:options]
  end
end
