## What is this
this project is make because of my laptop is not support nbfc to control fan speed but it have only asusctl can control fan speed by changing cpu profile but it run only about 30 second

this script is making asusctl change cpu profile auto when you start gamemode

i mean when in gamemode it change profile in to Performane
but when not in gamemode it change profile back in to Balanced

## Requirement
just need only 2 tool
- **asusctl**
- **gamemode**

if you not installed 
this script will auto install it

but if error try to install by your self

## Usage
run this script in your terminal *require sudo
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
