execute "Add flathub repository" do
  user node[:user]
  command "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
  not_if "test -n \"$(flatpak remotes | grep flathub)\""
end
