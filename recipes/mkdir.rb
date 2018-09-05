dirs = [
  ENV["HOME"] + "/.vim",
  ENV["HOME"] + "/.ghq"
]

dirs.each do |dir|
  execute "mkdir ~/.vim" do
    user node[:user]
    command "mkdir -p #{dir}"
    not_if "test -d #{dir}"
  end
end
