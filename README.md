## Cyber Security GeoIP Attack Map Visualization

This geoip attack map visualizer was developed to display network attacks on
your organization in real time. The data server follows a syslog file, and
parses out source IP, destination IP, source port, and destination port.
Protocols are determined via common ports, and the visualizations vary in color
based on protocol type.

![Demo Screenshot](screenshot/screenshot.png)

## Important

This program relies entirely on syslog, and because all appliances format logs differently, you will need to customize the log parsing function(s). If your organization uses a security information and event management system (SIEM), it can probably normalize logs to save you a ton of time writing regex.

1. Send all syslog to SIEM.
2. Use SIEM to normalize logs.
3. Send normalized logs to the box (any Linux machine running syslog-ng will work) running this software so the data server can parse them.

## Configs

1. Make sure in **/etc/redis/redis.conf** to change **bind 127.0.0.1** to **bind 0.0.0.0** if you plan on running the DataServer on a different machine than the AttackMapServer.
2. Make sure that the WebSocket address in **/AttackMapServer/index.html** points back to the IP address of the **AttackMapServer** so the browser knows the address of the WebSocket.
3. Download the MaxMind GeoLite2 database, and change the db_path variable in **DataServer.py** to the wherever you store the database.
   - ./db-dl.sh
4. Add headquarters latitude/longitude to hqLatLng variable in **index.html**
5. Use syslog-gen.py, or syslog-gen.sh to simulate dummy traffic "out of the box."
6. **IMPORTANT: Remember, this code will only run correctly in a production environment after personalizing the parsing functions. The default parsing function is only written to parse ./syslog-gen.sh traffic.**

## Bugs, Feedback, and Questions

If you find any errors or bugs, please let me know. Questions and feedback are also welcome, and can be sent to mcmay.web@gmail.com, or open an issue in this repository.

## Deploy example

Tested on Ubuntu 16.04 LTS.

- Clone the application:

  ```sh
  git clone https://github.com/matthewclarkmay/geoip-attack-map.git
  ```

- Install system dependencies:

  ```sh
  sudo apt install python3-pip redis-server

  ```

- Install python requirements:

  ```sh
  cd geoip-attack-map
  sudo pip3 install -U -r requirements.txt

  ```

- Start Redis Server:

  ```sh
  redis-server

  ```

- Configure the Data Server DB:

  ```sh
  cd DataServerDB
  ./db-dl.sh
  cd ..

  ```

- Start the Data Server:

  ```sh
  cd DataServer
  sudo python3 DataServer.py

  ```

- Start the Syslog Gen Script, inside DataServer directory:

  - Open a new terminal tab (Ctrl+Shift+T, on Ubuntu).

    ```sh
    ./syslog-gen.py
    ./syslog-gen.sh
    ```

- Configure the Attack Map Server, extract the flags to the right place:

  - Open a new terminal tab (Ctrl+Shift+T, on Ubuntu).

    ```sh
    cd AttackMapServer/
    unzip static/flags.zip
    ```

- Start the Attack Map Server:

  ```sh
  sudo python3 AttackMapServer.py
  ```

- Access the Attack Map Server from browser:

  - [http://localhost:8888/](http://localhost:8888/) or [http://127.0.0.1:8888/](http://127.0.0.1:8888/)

  - To access via browser on another computer, use the external IP of the machine running the AttackMapServer.

  - Edit the IP Address in the file "/static/map.js" at "AttackMapServer" directory. From:

    ```javascript
    var webSock = new WebSocket("ws:/127.0.0.1:8888/websocket");
    ```

  - To, for example:

    ```javascript
    var webSock = new WebSocket("ws:/192.168.1.100:8888/websocket");
    ```

  - Restart the Attack Map Server:

    ```sh
    sudo python3 AttackMapServer.py
    ```

  - On the other computer, points the browser to:

    ```sh
    http://192.168.1.100:8888/
    ```
