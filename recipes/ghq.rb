node[:ghq].each do |repository|
  ghq repository do
    user node[:user]
    action :update
    options "-p"
  end
end
