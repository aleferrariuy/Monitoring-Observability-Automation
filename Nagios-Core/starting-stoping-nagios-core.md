# Starting, Restarting, Stoping Nagios Core

## Starting Nagios Core
### Option 1
We can use the Nagios binary, with the "d" option, to start the Nagios Core daemon:

    $ sudo /usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg

### Option 2
An easy way to start the Nagios Core daemon is by using the init script as follows:

    $ sudo /etc/rc.d/init.d/nagios start

Like other init scripts, depending on your Linux distribution, you may start it like any other service. In my case, on Ubuntu, I run:

    $ sudo systemctl start nagios
    
## Restarting Nagios Core
### Option 1

An easy way to start the Nagios Core daemon is by using the init script as follows:

    $ sudo /etc/rc.d/init.d/nagios reload

### Option 2

The Nagios Core process can be restarted by sending a SIGHUP signal as follows:

    $ sudo kill -HUP <nagios_pid>

note: To obtain the PID (process identifier), you have two options: the first is on the "Home" page of your Nagios Core, where this information is displayed; the second is to execute the following line of code in your console:

    $ ps aux  |  grep -i nagios  |  awk '{print $2}'  |  xargs sudo kill -HUP
    
## Stoping Nagios Core
### Option 1

    $ sudo /etc/rc.d/init.d/nagios stop

### Option 2

    $ sudo systemctl stop nagios

### Option 3

    $ sudo kill -9 <nagios_pid>

---/---
