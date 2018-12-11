
# Automated open vpn road warrior cloud init 

The [road warrior vpn setup](https://github.com/Nyr/openvpn-install) is a great tool to get a basic open vpn server up and running on an ubuntu instance. However it requires human interaction which makes it not useful as-is for automated provisioning of new instances, and doesn't support customization of the openvpn server.conf. 

## Usage 

Use cloud-init.sh as user data for your ec2 instance, which scripts checking out this git repo and running the server configuration script.  You'll want to customize with your own server.conf either by forking this repository or modifying user-data.sh to overwrite the repo's `server.conf` after checkout. 

## How it works

The configuration script installs the `expect` utility to script user input, gathers environment info like server IP address, and runs the expect script against the road warrior setup script. At the end it replaces the generated server.conf with that from the project, makes sure the openvpn version is upgraded to latest in the package manager, and restarts the service. 
