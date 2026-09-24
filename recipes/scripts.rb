# alias script for pbcopy
file "/usr/local/bin/pbcopy" do
  content "#!/bin/bash\n\nxsel -ib \"$@\"\n"
  mode "755"
end
