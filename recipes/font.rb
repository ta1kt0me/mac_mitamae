execute "Install font for powerline" do
  user node[:user]
  command 'cd "$(/usr/local/bin/ghq list -p | grep powerline/fonts)" && ./install.sh'
end

execute "Install kinto font" do
  user node[:user]
  command 'cd "$(/usr/local/bin/ghq list -p | grep ookamiinc/kinto)" && find "Kinto Sans" -name "*.[ot]tf" -or -name "*.pcf.gz" -type f | xargs -I% cp "%" ${HOME}/.local/share/fonts/ && fc-cache -f ${HOME}/.local/share/fonts/'
end
