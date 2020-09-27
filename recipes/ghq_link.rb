def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

home_path   = "#{home_dir}/" + node[:user]
config_path = home_path + "/.config"
ghq_path    = `sudo su - #{node[:user]} -c "git config --get ghq.root"`.gsub("\n", "")

links = [
  { from: home_path   + "/.vimrc",            to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" },
  { from: home_path   + "/.vim/after",        to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/after" },
  { from: home_path   + "/.vim/snippets",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim/snippets" },
  { from: config_path + "/nvim",              to: ghq_path + "/github.com/ta1kt0me/vimrc/.vim" },
  { from: config_path + "/nvim/init.vim",     to: ghq_path + "/github.com/ta1kt0me/vimrc/.vimrc" }
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
  end
end
