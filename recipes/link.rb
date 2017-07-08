dropbox_path = ENV["HOME"] + "/Dropbox"
config_path  = ENV["HOME"] + "/.config"
ghq_path     = `git config --get ghq.root`.gsub("\n", "")

links = [
  { from: ENV["HOME"] + "/.vimrc",            to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: ENV["HOME"] + "/.tmux.conf",        to: dropbox_path + "/Public/tmux/.tmux.conf" },
  { from: ENV["HOME"] + "/.gitignore_global", to: dropbox_path + "/share/dotfile/.gitignore_global" },
  { from: ENV["HOME"] + "/.rubocop.yml",      to: dropbox_path + "/Public/rubocop/.rubocop.yml" },
  { from: ENV["HOME"] + "/.sheets",           to: dropbox_path + "/Public/sheet/.sheets" },
  { from: ENV["HOME"] + "/.ssh",              to: dropbox_path + "/Dev/ssh" },
  { from: ENV["HOME"] + "/.vimrc.local",      to: dropbox_path + "/Public/vim/.vimrc.local" },
  { from: ENV["HOME"] + "/.vimrc.preset",     to: dropbox_path + "/Public/vim/.vimrc.preset" },
  { from: ENV["HOME"] + "/vimwiki",           to: dropbox_path + "/Public/vim/vimwiki" },
  { from: config_path + "/powerline",         to: dropbox_path + "/Public/powerline" },
  { from: config_path + "/nvim",              to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim" },
  { from: config_path + "/nvim/init.vim",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: config_path + "/fish",              to: ghq_path + "/github.com/ta1kt0me/fish-config" },
  { from: config_path + "/fish/local.fish",   to: dropbox_path + "/Public/fish/local.fish" }
]

links.each do |link|
  link link[:from] do
    to link[:to]
  end
end
