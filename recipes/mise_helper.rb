include_recipe 'directory_helper'

module MiseHelper
  def self.path(node)
    "#{DirectoryHelper.local_bin_path(node)}/mise"
  end

  # tools pinned to a version in node.yml
  def self.pinned_tools(node)
    node[:mise][:packages].reject { |package| package.end_with?("@latest") }
  end

  # tools following the latest version, which bin/update updates
  def self.latest_tools(node)
    node[:mise][:packages].select { |package| package.end_with?("@latest") } +
      node[:mise][:plugins].map { |plugin| "#{plugin}@latest" }
  end
end
