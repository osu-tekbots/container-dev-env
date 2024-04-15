# Setting Up Local Development

## Phase 1: Set up TekBots Site
1. Clone the git repo into a subdirectory (eg `public`)
    ```sh
    git clone https://github.com/osu-tekbots/tekbot-application.git public
    ```

2. In `./public`, add `config.ini`:
    ```ini
    ; All files referenced through the configuration are relative to this private path

    private_files = /var/www ; Based on Docker container path, *NOT* OS filepath

    [server]
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
    log_file = .private/ ; Path to where the monthly log file should be created
    level = info

    [database]
    config_file = database.ini

    [checkout]
    checkout_duration = 24
    reservation_duration = 1
    ```

3. Add `./.private` directory (outside `./public`). *The directory name should match logger.log_file in `config.ini`*

4. Add `./database.ini` directory (outside `./public`):
    ```ini
    host = 127.0.0.1        ; May need to be replaced with your local IP
    user = root
    password = db-password  ; Whatever password you use later (when running dev-setup.sh)
    db_name = tekbots       ; Whatever database name you use later (when running dev-setup.sh)
    ```

5. Run `sh dev-setup.sh /path/to/project/root/public /path/to/project/root` (or `dev-setup.bat`)
    1. DB Password: `db-password` or whatever you chose as `password` in Step 4
    2. Default database: `tekbots` or whatever you chose as `db_name` in Step 4

6. Visit `localhost:7000` and start working!