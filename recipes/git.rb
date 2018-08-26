node[:git].each do |item|
  git "#{ENV['HOME']}/#{item[:dist]}" do
    user node[:user]
    repository item[:repo]
  end
end
