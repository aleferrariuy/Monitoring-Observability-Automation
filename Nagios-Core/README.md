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

The *objects* folder is very important, as it contains the Nagios Core configuration files, with the *cfg* extension.

It's important to consider making a backup copy of the files you want to edit beforehand.

At its first level, *objects* includes the main Nagios Core configuration file: *nagios.cfg*
                         
### External support resources

- Nagios Core Documents
    + ![Nagios Core Documents](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/toc.html)
- Nagios Support Knowledgebase
    + ![Nagios Support Knowledgebase](https://support.nagios.com/kb/category.php)
