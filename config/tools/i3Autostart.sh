#!/bin/sh
#----------------------------------------#
# Auto Start App on specific workspace.  #
#----------------------------------------#

# Back to Workspace 1
i3-msg "workspace 1;"
i3-msg "workspace 1; floating disable"
i3-msg "workspace 1; split h"

# Setup Workspace 2
i3-msg "workspace 2; exec alacritty"
sleep 0.8;
i3-msg "workspace 2; floating disable"
i3-msg "workspace 2; split h"

# Setup Workspace 3
i3-msg "workspace 3; exec firefox"
sleep 0.8;
i3-msg "workspace 3; floating disable"
i3-msg "workspace 3; split h"

# Setup Workspace 4
i3-msg "workspace 4; exec telegram-desktop"
sleep 0.8;
i3-msg "workspace 4; floating disable"
i3-msg "workspace 4; split h"

# Setup Workspace 5
i3-msg "workspace 5; exec thunderbird"
sleep 0.8;
i3-msg "workspace 5; floating disable"
i3-msg "workspace 5; split h"

# Setup Workspace 6
i3-msg "workspace 6; exec spotify"
sleep 0.8;
i3-msg "workspace 6; floating disable"
i3-msg "workspace 6; split h"

# Back Workspace
i3-msg "workspace 1"
