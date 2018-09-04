dropbox_path = ENV["HOME"] + "/Dropbox"
fish_path  = ENV["HOME"] + "/.config/fish"

links = [
  { from: fish_path + "/local.fish", to: dropbox_path + "/Public/fish/local.fish" }
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
  end
end
