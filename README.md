# What is this
this project is make because of my laptop is not support nbfc to control fan speed but it have only asusctl can control fan speed by changing cpu profile but it run only about 30 second

## What scripts do
this script is making asusctl change cpu profile auto

by this mode

| Profile  | activation time |
| ------------- | ------------- |
| Gamemoderun  | change asusctl profile to Performance every 30 second   |
| asusctl profile -P Performance  | change asusctl profile to Performance every 30 second  |
| asusctl profile -P Balanced  | one time change tp Balanced  |
| asusctl profile -P Quiet  | one time change to Quiet  |


## Requirement
just need only 2 tool
- **asusctl**
- **gamemode**
- systemd

if you not installed 
this script will auto install it

but if error try to install by your self

## Usage
run this script in your terminal
```
curl -L https://raw.githubusercontent.com/AnsuNotMyName/asusctl-auto-profile/refs/heads/main/auto-asusctl-profile.sh | bash
```

## Update
just run install command again
```
curl -L https://raw.githubusercontent.com/AnsuNotMyName/asusctl-auto-profile/refs/heads/main/auto-asusctl-profile.sh | bash
```

## Log
you can check log by type this command in you terminal
```
journalctl --user -u asus-performance.service -f
```
