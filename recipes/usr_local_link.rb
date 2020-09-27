def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

links = [
  {
    from: "/usr/local/bin/docker-compose",
    to: "#{home_dir}/#{node[:user]}/.pyenv/shims/docker-compose"
  }
]

links.each do |link|
  link link[:from] do
    to link[:to]
  end
end
