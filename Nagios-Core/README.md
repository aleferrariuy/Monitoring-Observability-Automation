# Nagios Core

### Directories structure

    /usr/local/nagios/etc/objects
                     /bin
                     /libexec
                     /sbin
                     /share
                     /var/archives
                         /rw
                         /spool

As you can see, the structure is not complex.

The *etc* folder is very important, as it contains the Nagios Core configuration files, with the *cfg* extension.

It also contains by default the *objects* folder, which also contains by default *cfg* configuration files as a starting point.

It's important to consider making a backup copy of the files you want to edit beforehand.

At its first level, *etc* includes the main Nagios Core configuration file: *nagios.cfg*

*cgi.cfg* ............ Other configuration file

*resource.cfg* ....... User macros               

*htpasswd.users* ..... User accounts


*commands.cfg* ....... Commands to be invoked by Nagios Core to monitor hosts or services, using plugins from its libraries, or an agent hosted on the hosts to be monitored.

*contacts.cfg* ....... Declaration of contacts or command groups that Nagios Core will notify if necessary in the event of an incident.

*localhost.cfg* ...... This file declares the host where Nagios Core itself is hosted, as well as all the basic services it runs. For these, the necessary monitoring commands are defined.

*templates.cfg* ...... Both hosts and services can often have redundant or repetitive feature patterns. To optimize time and facilitate reuse or portability, reusable templates can be defined.

*timeperiods.cfg* .... This file declares the "time periods" to be used in the other configuration files.


### External support resources

- Nagios Core Documents
    + ![Nagios Core Documents](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/toc.html)
- Nagios Support Knowledgebase
    + ![Nagios Support Knowledgebase](https://support.nagios.com/kb/category.php)
