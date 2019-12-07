links = [
  {
    from: "/usr/local/bin/docker-compose",
    to: "/home/#{node[:user]}/.pyenv/shims/docker-compose"
  }
]

links.each do |link|
  link link[:from] do
    to link[:to]
  end
end
