execute "mkdir ~/.vim" do
  vimdir = ENV["HOME"] + "/.vim"
  command "mkdir -p #{vimdir}"
  not_if "test -d #{vimdir}"
end
