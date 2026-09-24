include_recipe 'directory_helper'

home_path   = DirectoryHelper.home_path(node)
config_path = home_path + "/.config"
ghq_root    = node[:git_config].find { |config| config[:key] == "ghq.root" }
raise "First, set ghq.root in git_config of node.yml" unless ghq_root
ghq_path    = ghq_root[:value].sub("$HOME", home_path)

links = [
  { from: home_path   + "/.vimrc",            to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: home_path   + "/.vim/after",        to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/after" },
  { from: home_path   + "/.vim/snippets",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/snippets" },
  { from: config_path + "/nvim",              to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim" },
  { from: config_path + "/nvim/init.vim",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
    not_if "test -e #{link[:from]}"
  end
end
