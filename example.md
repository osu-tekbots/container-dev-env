# Setting Up Local Development

## Phase 1: Set up TekBots Site
1. Download Docker Desktop (links in the [readme](./README.md)). Open Docker Desktop and agree to the Terms and Conditions.

1. Create a directory for the TekBots site. (eg `mkdir ~/GitHub/TekBots`)

1. Clone the git repo into your TekBots directory =(`/TekBots/tekbot-application`)
    ```console
    user@laptop:~/GitHub/TekBots$ git clone https://github.com/osu-tekbots/tekbot-application.git
    ```
1. Rename the tekbot-application folder to 'public' =(`/TekBots/public`)
    
1. In `TekBots/public/`, add `config.ini`:
    ```ini
    ; All files referenced through the configuration are relative to this private path

    private_files = /var/www/html/.private ; Based on Docker container path, *NOT* OS filepath

    [server]
    environment = dev
    display_errors = yes
    display_errors_severity = all
    auth_providers_config_file = auth.ini
    upload_project_image_file_path = public/images/equipment
    upload_part_image_files_path = /dev/null
    upload_part_datasheet_files_path = /dev/null

    [email]
    subject_tag = OSU TekBots
    from_address = <your_onid>@oregonstate.edu      ; Replace with your ONID
    worker_maillist = <your_onid>@oregonstate.edu   ; Replace with your ONID
    cron_frequency = 3
    admin_addresses[] = 

    [keys]
    client_id = ; Something
    client_secret = ; Something

    [client]
    base_url = http://localhost:7000/               ; Update if you use a different port

    [logger]
    log_file = logs/ ; Path to where the monthly log file should be created
    level = info

    [database]
    config_file = database.ini

    [checkout]
    checkout_duration = 24
    reservation_duration = 1
    ```

1. Add a `.private/` directory (in `TekBots/public/`).

1. Add a `database.ini` file (in `TekBots/public/.private/`):
    ```ini
    host = osu-mysql-db     ; May need to be replaced with your local IP
    user = root
    password = db-password  ; Whatever password you use later (when running dev-setup.sh)
    db_name = tekbots       ; Whatever database name you use later (when running dev-setup.sh)
    ```
    //The password and db_name when you are running dev-setup have to be exactly the same as the ones in this file

1. Add a 'logs' folder in the .private in public; this is where debugging logs will generate = (TekBots/public/.private/logs)

1. Clone this repo (container-dev-env) into your TekBots folder = (TekBots/container-dev-env)
    ```console
    user@laptop:~/GitHub$ git clone https://github.com/osu-tekbots/container-dev-env.git 
    ```
1. Create a .private folder in your TekBots folder; this is different from the one in public; this folder will largely remain empty aside from some temp files = (TekBots/.private)
   
//This finishes the project directory structure
 
1. Navigate to the container-dev-env folder and set up the docker containers using the setup script in this repo (`.sh` on Mac/ Linux or `.bat` script on Windows).
    ```console
    user@laptop:~/GitHub/container-dev-env$ sh dev-setup.sh /path/to/project/root/public    /path/to/project/root/.private

    user@laptop:~/GitHub/container-dev-env$ ./dev-setup.bat /path/to/project/root/public    /path/to/project/root/.private
    ```
    - `/path/to/project/root/public` would be `~/GitHub/TekBots/public` in the previous suggestions
    - `/path/to/project/root/.private` would be `~/GitHub/TekBots/.private` in the previous suggestions
      
    - You will be prompted for two values:
        1. DB Password: `db-password` or whatever you chose as `password` in Step 4
        2. Default database: `tekbots` or whatever you chose as `db_name` in Step 4

1. Next run dev-start (either sh dev-setup.sh or ./dev-setup.bat depending on OS)

//Prepare the database next: 

1. Download the TekBots database from [the CoE phpMyAdmin instance](https://tools.engr.oregonstate.edu/phpMyAdmin) This only needs to be done once
    1. Log in using the credentials in `tekbotSuite/database.ini`
    2. Click on "tekbots" just below "information_schema"
    3. Click on "Tables" just below "tekbots"
    4. Click on "Export" in the main navbar across the top of the page
    5. (optional) Click "custom" and deselect any unneeded tables
    6. Click the "Export" button at the bottom of the page
    7. Take the exported file and zip it to create a zip folder

1. To import the database locally. This will need to be done every time you teardown and setup the containers
    1. Open [phpMyAdmin locally](http://localhost:5000) and log in with the credentials from Step 4 (username should be root and the password is whatever you selected)
    2. Click on "tekbots" (or whatever you named the database in Step 4)
    3. Upload the `.sql` file you downloaded
    4. Click "upload"
    5. If an error occurs, you may need to zip the file before uploading it
    > **NOTE:** Remember the number of executed queries shown in the yellow confirmation alert. If data or tables seem to be missing:
    >    1. Return to the "Import" tab
    >    2. Re-upload the `.sql` file
    >    3. In the "partial import" section, enter the number of queries already executed


1. Visit `localhost:7000` to visit the website and start working!

1. To stop the containers: run sh dev-stop.sh or ./dev-stop.bat
1. To restart the database and website from fresh, and delete the containers, run sh dev-teardown.sh or ./dev-teardown.bat
1. To change the ports of the mysql database (if you already have one running on 3306) update dev-vars and run teardown + setup again
