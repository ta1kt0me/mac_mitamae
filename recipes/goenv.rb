def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

home_path = "#{home_dir}/" + node[:user]

# goenv
goenv = "#{home_path}/.goenv/bin/goenv"
node[:goenv][:versions].each do |version|
  execute "Install go #{version}" do
    user node[:user]
    command "#{goenv} install #{version}"
    not_if "test $(#{goenv} versions --bare | grep #{version})"
  end
end

node[:goenv][:global].tap do |version|
  execute "Set goenv global #{version}" do
    user node[:user]
    command "#{goenv} global #{version}"
    not_if "test $(#{goenv} version-name | grep #{version})"
  end

  execute "init go.mod" do
    user node[:user]
    command "#{home_path}/.goenv/shims/go mod init gotools"
    cwd "#{home_path}/.gotools"
    not_if "test -e #{home_path}/.gotools/go.mod"
  end

  GOPATH = "#{home_path}/go/#{version}".freeze
  GOBIN = GOPATH + "/bin"
  ["go-get-release", "detect-latest-release"].each do |pkg|
    execute "Download #{pkg}" do
      user node[:user]
      command "#{home_path}/.goenv/shims/go get -u github.com/rhysd/go-github-selfupdate/cmd/#{pkg}"
      cwd "#{home_path}/.gotools"
      not_if "test -e #{GOBIN}/#{pkg}"
    end
  end

  execute "Download sops" do
    user node[:user]
    command "#{home_path}/.goenv/shims/go get -u go.mozilla.org/sops/cmd/sops"
    cwd "#{home_path}/.gotools"
    not_if "test -e #{GOBIN}/sops"
  end

  node[:go_packages].each do |package|
    execute "Install #{package}" do
      user node[:user]
      command "GOPATH=#{GOPATH} #{GOBIN}/go-get-release github.com/#{package}"
    end
  end
end
