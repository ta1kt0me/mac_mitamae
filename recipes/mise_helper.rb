include_recipe 'directory_helper'

module MiseHelper
  def self.path(node)
    "#{DirectoryHelper.local_bin_path(node)}/mise"
  end

  # tools pinned to a version in node.yml
  def self.pinned_tools(node)
    node[:mise][:packages].reject { |package| package.end_with?("@latest") }
  end

  # the newest pinned version of each tool, which becomes the global default
  def self.default_pinned_tools(node)
    pinned_tools(node)
      .group_by { |tool| tool.split("@").first }
      .map { |_, tools| tools.max { |a, b| version_numbers(a) <=> version_numbers(b) } }
  end

  def self.version_numbers(tool)
    tool.split("@").last.split(".").map(&:to_i)
  end

  # tools following the latest version, which bin/update updates
  def self.latest_tools(node)
    node[:mise][:packages].select { |package| package.end_with?("@latest") } +
      node[:mise][:plugins].map { |plugin| "#{plugin}@latest" }
  end
end
