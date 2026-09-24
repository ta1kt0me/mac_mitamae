include_recipe 'directory_helper'

ghq_root = DirectoryHelper.ghq_root(node)

execute "Install font for powerline" do
  user node[:user]
  command "cd #{ghq_root}/github.com/powerline/fonts && ./install.sh"
  not_if "fc-list | grep -qi powerline"
end

execute "Install kinto font" do
  user node[:user]
  command "cd #{ghq_root}/github.com/ookamiinc/kinto && find 'Kinto Sans' -name '*.[ot]tf' -or -name '*.pcf.gz' -type f | xargs -I% cp '%' ${HOME}/.local/share/fonts/ && fc-cache -f ${HOME}/.local/share/fonts/"
  not_if "fc-list | grep -qi 'kinto sans'"
end
