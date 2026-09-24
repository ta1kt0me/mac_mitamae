module DirectoryHelper
  def self.home(node)
    node[:platform] == "darwin" ? "/Users" : "/home"
  end

  def self.home_path(node)
    "#{home(node)}/#{node[:user]}"
  end
end
