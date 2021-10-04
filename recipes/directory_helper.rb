module DirectoryHelper
  def self.home(node)
    node[:platform] == "darwin" ? "/Users" : "/home"
  end
end
