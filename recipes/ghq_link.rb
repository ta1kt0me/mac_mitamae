config_path  = ENV["HOME"] + "/.config"
ghq_path     = `git config --get ghq.root`.gsub("\n", "")

links = [
  { from: ENV["HOME"] + "/.vimrc",            to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: ENV["HOME"] + "/.vim/after",        to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/after" },
  { from: ENV["HOME"] + "/.vim/snippets",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/snippets" },
  { from: config_path + "/nvim",              to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim" },
  { from: config_path + "/nvim/init.vim",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" }
]

links.each do |link|
  link link[:from] do
    to link[:to]
  end
end
