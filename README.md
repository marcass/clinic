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

## Starting mosquitto on C.H.I.P.

On startup the systemd script fails to start mosqutto. I haven't sorted this yet, but ssh'ing into chip and running

```
mosquitto -d
````

Solves the issue. Follwing this the python script needs to be started in order to start the door-chime service

```
systemctl start door-chime
```

