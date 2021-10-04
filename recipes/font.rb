include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]
go_global_bin = "#{home_path}/go/#{node[:goenv][:global]}/bin"
ghq_cli = "#{go_global_bin}/ghq"

execute "Install font for powerline" do
  user node[:user]
  command "cd \"$(#{ghq_cli} list -p | grep powerline/fonts)\" && ./install.sh"
end

execute "Install kinto font" do
  user node[:user]
  command "cd \"$(#{ghq_cli} list -p | grep ookamiinc/kinto)\" && find 'Kinto Sans' -name '*.[ot]tf' -or -name '*.pcf.gz' -type f | xargs -I% cp '%' ${HOME}/.local/share/fonts/ && fc-cache -f ${HOME}/.local/share/fonts/"
end
