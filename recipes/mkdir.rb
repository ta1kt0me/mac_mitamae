dirs = [
  ENV["HOME"] + "/.vim",
  ENV["HOME"] + "/.ghq",
  ENV["HOME"] + "/.ssh_local"
]

dirs.each do |dir|
  execute "mkdir #{dir}" do
    user node[:user]
    command "mkdir -p #{dir}"
    not_if "test -d #{dir}"
  end
end
