

Every time we modify the configuration files, we must run a security check.

It is important to do this before restarting Nagios Core, as it will shut down if the configuration contains errors.

To verify the configuration, we must run the Nagios Core binary with the -v command line option, as shown below:

'$ sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg'
