execute "Add flathub repository" do
  user node[:user]
  command "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
  not_if "test -n \"$(flatpak remotes | grep flathub)\""
end

execute "Install vocal" do
  user node[:user]
  command "flatpak install -y flathub com.github.needleandthread.vocal"
  not_if "test -n \"$(flatpak list | grep vocal)\""
end

execute "Add nuvola repository" do
  user node[:user]
  command "flatpak remote-add --if-not-exists nuvola https://dl.tiliado.eu/flatpak/nuvola.flatpakrepo"
  not_if "test -n \"$(flatpak remotes | grep nuvola)\""
end

execute "Install pocket casts" do
  user node[:user]
  command "flatpak install -y nuvola eu.tiliado.NuvolaAppPocketCasts"
  not_if "test -n \"$(flatpak list | grep PocketCasts)\""
end
