

Every time we modify the configuration files, we must run a security check.

It is important to do this before restarting Nagios Core, as it will shut down if the configuration contains errors.

To verify the configuration, we must run the Nagios Core binary with the -v command line option, as shown below:

    $ sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

If everything is configured correctly, you should get an output similar to the following:

    example 1 here

If there are errors in the configuration files, the output will tell you their location, or where you can start looking for them:

    example 2 here

Many times, the output may only warn you that within the configuration, some parameters warrant a "warning." However, these will not prevent Nagios from starting. Generally, they will compromise some functionality.

An example is if you configure the hosts without configuring the contacts that will receive notifications of host or service events. You would see output like the following:

    example 3 here
