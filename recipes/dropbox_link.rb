home_path    = "/home/" + node[:user]
dropbox_path = home_path + "/Dropbox"
config_path  = home_path + "/.config"

links = [
  { from: home_path + "/.tmux.conf",        to: dropbox_path + "/Public/tmux/.tmux.conf" },
  { from: home_path + "/.gitignore_global", to: dropbox_path + "/Dev/dotfile/.gitignore_global" },
  { from: home_path + "/.rubocop.yml",      to: dropbox_path + "/Public/rubocop/.rubocop.yml" },
  { from: home_path + "/.rufo",             to: dropbox_path + "/Dev/dotfile/.rufo" },
  { from: home_path + "/.sheets",           to: dropbox_path + "/Public/sheet/.sheets" },
  { from: home_path + "/.ssh",              to: dropbox_path + "/Dev/ssh" },
  { from: home_path + "/.essh",             to: dropbox_path + "/Dev/essh" },
  { from: home_path + "/.vimrc.local",      to: dropbox_path + "/Public/vim/.vimrc.local" },
  { from: home_path + "/.vimrc.preset",     to: dropbox_path + "/Public/vim/.vimrc.preset" },
  { from: home_path + "/.vim/colors",       to: dropbox_path + "/Public/vim/.vim/colors" },
  { from: home_path + "/.vim/ftdetect",     to: dropbox_path + "/Public/vim/.vim/ftdetect" },
  { from: home_path + "/.vim/ftplugin",     to: dropbox_path + "/Public/vim/.vim/ftplugin" },
  { from: home_path + "/vimwiki",           to: dropbox_path + "/Public/vim/vimwiki" },
  { from: config_path + "/powerline",       to: dropbox_path + "/Public/powerline" },
  { from: config_path + "/peco",            to: dropbox_path + "/Public/peco" }
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
  end
end
