node[:ghq].each do |repository|
  ghq repository do
    action :update
    options "-p"
  end
end
