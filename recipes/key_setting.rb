execute "Set key config for tweak" do
  user node[:user]
  command "gsettings set org.gnome.mutter overlay-key \"\""
  not_if "test \"$(gsettings get org.gnome.mutter overlay-key)\" = \"''\""
end
