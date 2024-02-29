class Specinfra::Command::Pop < Specinfra::Command::Ubuntu; end

if node[:platform] == "pop"
  node[:apt_packages].each do |item|
    user "root"
    package item
  end
end
