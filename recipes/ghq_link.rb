include_recipe 'directory_helper'

home_path   = DirectoryHelper.home_path(node)
ghq_path    = DirectoryHelper.ghq_root(node)

links = [
  { from: home_path   + "/.vimrc",            to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: home_path   + "/.vim/after",        to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/after" },
  { from: home_path   + "/.vim/snippets",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/snippets" },
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
    not_if "test -e #{link[:from]}"
  end
end
