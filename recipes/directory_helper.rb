module DirectoryHelper
  def self.home_path(node)
    home_dir = node[:platform] == "darwin" ? "/Users" : "/home"
    "#{home_dir}/#{node[:user]}"
  end

  def self.local_bin_path(node)
    "#{home_path(node)}/.local/bin"
  end

  # where eget installs the binary of a gh_repos entry in node.yml
  def self.eget_bin_path(node, gh_repo)
    "#{local_bin_path(node)}/#{gh_repo[:bin] || gh_repo[:repo].split('/').last}"
  end

  def self.ghq_root(node)
    config = node[:git_config].find { |c| c[:key] == "ghq.root" }
    raise "First, set ghq.root in git_config of node.yml" unless config

    value = config[:value]
    ["${HOME}", "$HOME", "~"].each do |prefix|
      return home_path(node) + value[prefix.size..-1] if value.start_with?(prefix)
    end
    value
  end
end
