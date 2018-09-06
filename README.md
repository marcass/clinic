# Setting up a new machine

## Things to do
1. Istall os of choice (using debian at present)
2. Install Chrome and get user to sign in
3. Setup printing
4. Optionally setup ftp server
5. Setup syncthing for appropriate folders

### Printing
1. Copy scripts to {home}/bin
2. Modify paths for local printers/enviornments
3. Install printers at localhost:631 (install CUPS if not already installed)
4. Move systemd script (change paths if necessary) to /etc/systemd/user/
4. enable user service unit `systemctl --user enable <systemd unit>`
5. start serveice systemctl --user start <systemd unit>`


