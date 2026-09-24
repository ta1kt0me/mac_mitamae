include_recipe 'directory_helper'

mise = "#{DirectoryHelper.local_bin_path(node)}/mise"

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
  not_if "test -x #{mise}"
end

node[:mise][:packages].each do |package|
  execute "Install #{package} via mise" do
    user node[:user]
    command "#{mise} install #{package}"
    not_if "#{mise} where #{package}"
  end

  execute "Activate #{package} via mise" do
    user node[:user]
    command "#{mise} use --global #{package}"
  end
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins install #{plugin}"
    only_if "test -z $(#{mise} ls #{plugin})"
  end

  execute "Update #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins update #{plugin}"
  end

  execute "Activate #{plugin} via mise" do
    user node[:user]
    command "#{mise} use --global #{plugin}@latest"
  end
end
