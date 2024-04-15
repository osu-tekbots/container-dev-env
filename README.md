# Container Development Environment Setup
The scripts in this repository help provide a local development environment for developing websites and web 
applications that will run on Oregon State Universtiy ENGR servers. The production servers run Apache 2.0 with PHP.

## Quickstart

1. Install [Docker](https://www.docker.com/) on your machine
   - [Windows](https://docs.docker.com/docker-for-windows/install/)
   - [Linux (Ubuntu)](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
1. Clone the repository to your machine
1. Run `sh dev-setup.sh` from the command line on Linux or `dev-setup.bat` from the command prompt on Windows for 
   details about the  setup scripts

> Note: On new Macs, you may need to deactivate AirPlay receiver to use ports 5000 and 7000 (default for this tool), or redefine those ports in `dev-vars.local.sh`.

## Environment Setup

### See an example setup [here](./example.md)

The scripts in this repository create three Docker containers:
- A MySQL container
- A phpMyAdmin Container
- An Apache 2.0/PHP web server container

These three containers work together to provide a local, live interactive development environment for PHP websites 
and applications. There are default configuration values for the setup in `dev-vars.{sh,bat}`. These values can be 
overloaded by creating a `dev-vars.local.{sh,bat}` file. All `.local.{sh,bat}` files will be ignored by Git.

The setup scripts take two arguments: the location of the public files to be served by the web server, and the location
of private files outside the public web root but accessible by the web application (such as configuration files, 
secrets, etc.). An example of running the script in Linux would be:

```sh
sh dev-setup.sh /home/john/websites/osu/capstone/public /home/john/websites/osu/capstone
```

The above command assumes that there is a directory `websites/osu/capstone` under the user `john` that contains 
private configuration files for a website (in this example the Capstone site). The `websites/osu/capstone/public` 
directory contains the HTML, CSS, PHP, and other assets that will be served by the Apache web server. These files are 
assumed to be publicly accessible over the internet from a browser, baring any `.htaccess` file rules that may be 
present.

## Pausing and Resuming Development
You can easily shut down the containers without destroying them to free up computer resources and preserve current
environment settings with the `dev-stop.{sh,bat}` script.

After you have paused development, you can start the containers again using the `dev-start.{sh,bat}` script.

## Switch Development Contexts
It may be the case that you want to work on a different website frontend that shares same backend database with
other sites you are working on. Rather than destroying the containers and starting over again, you can use the
`dev-switch.{sh,bat}` script to easily switch development contexts and restart the web server with different public
and private directory paths.

```sh
sh dev-switch.sh /path/to/new/public /path/to/new/private
```

## Resources
- [Docker documentation](https://docs.docker.com/)