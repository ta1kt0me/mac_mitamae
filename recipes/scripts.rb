execute "add alias script for pbcopy" do
  command "echo -e \"#!/bin/bash\n\nxsel -ib \$@\" > /usr/local/bin/pbcopy && chmod +x /usr/local/bin/pbcopy"
  not_if "test -f /usr/local/bin/pbcopy"
end
