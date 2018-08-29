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

  node[:linuxbrew_packages].each do |item|
    LINUX_BREW = "#{HOME}/.linuxbrew/bin/brew"
    execute "Install #{item}" do
      user node[:user]
      command "#{LINUX_BREW} install #{item}"
      not_if "test -n $(#{LINUX_BREW} list | grep #{item})"
    end
  end
end

node[:packages_with_option].each do |item|
  package item[:name] do
    options item[:options]
  end
end
