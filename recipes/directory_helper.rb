module DirectoryHelper
  def self.home_path(node)
    home_dir = node[:platform] == "darwin" ? "/Users" : "/home"
    "#{home_dir}/#{node[:user]}"
  end
end
