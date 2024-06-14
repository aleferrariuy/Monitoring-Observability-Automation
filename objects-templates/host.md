Complete...
~~~
define host {
	host_name                     host_name
	alias                         alias
	display_name                  display_name
	address                       address
	parents                       host_names
	importance                    #
	hostgroups                    hostgroup_names
	check_command                 command_name
	initial_state                 [o,d,u]
	max_check_attempts            #
	check_interval                #
	retry_interval                #
	active_checks_enabled         [0/1]
	passive_checks_enabled        [0/1]
	check_period                  timeperiod_name
	obsess_over_host|obsess       [0/1]
	check_freshness               [0/1]
	freshness_threshold           #
	event_handler                 command_name
	event_handler_enabled         [0/1]
	low_flap_threshold            #
	high_flap_threshold           #
	flap_detection_enabled        [0/1]
	flap_detection_options        [o,d,u]
	process_perf_data             [0/1]
	retain_status_information     [0/1]
	retain_nonstatus_information  [0/1]
	contacts                      contacts
	contact_groups                contact_groups
	notification_interval         #
	first_notification_delay      #
	notification_period           timeperiod_name
	notification_options          [d,u,r,f,s]
	notifications_enabled         [0/1]
	stalking_options              [o,d,u,N]
	notes                         note_string
	notes_url                     url
	action_url                    url
	icon_image                    image_file
	icon_image_alt                alt_string
	vrml_image                    image_file
	statusmap_image               image_file
	2d_coords                     x_coord,y_coord
	3d_coords                     x_coord,y_coord,z_coord
}
~~~
Required...
~~~
define host {
	host_name                     host_name
	address                       address
	max_check_attempts            #
	check_period                  timeperiod_name
	notification_period           timeperiod_name
}
~~~
## Descripciones d elas Directivas: ##

host_name: 	
Esta directiva se utiliza para definir un nombre corto utilizado para identificar el host. 
Se utiliza en definiciones de servicios y grupos de hosts para hacer referencia a este host en particular. 
Los hosts pueden tener múltiples servicios (que son monitoreados) asociados a ellos. 
Cuando se usa correctamente, la variable $HOSTNAME$ contendrá este nombre corto.

alias: 	
Esta directiva se utiliza para definir un nombre o descripción más largo que se utiliza para identificar el host. 
Se proporciona para permitirle identificar más fácilmente un host en particular. 
Cuando se usa correctamente, la variable $HOSTALIAS$ contendrá este alias/descripción.

address: 	
Esta directiva se utiliza para definir la dirección del host. 
Normalmente, se trata de una dirección IP, aunque realmente podría ser cualquier cosa que desee (siempre que pueda 
usarse para comprobar el estado del host). 
Puede utilizar un FQDN para identificar el host en lugar de una dirección IP, pero si los servicios DNS no están disponibles, 
esto podría causar problemas.
Cuando se usa correctamente, la variable $HOSTADDRESS$ contendrá esta dirección. 
Nota: Si no especifica una directiva de dirección en una definición de host, se utilizará el nombre del host como dirección. 
Sin embargo, una advertencia al hacer esto: si el DNS falla, la mayoría de las comprobaciones de su servicio fallarán porque 
los complementos no podrán resolver el nombre del host.

display_name: 	
Esta directiva se utiliza para definir un nombre alternativo que debe mostrarse en la interfaz web de este host. 
Si no se especifica, el valor predeterminado es el valor que especifique para la directiva host_name. 
Nota: Los CGI actuales no utilizan esta opción, aunque las versiones futuras de la interfaz web sí lo harán.

parents: 	
Esta directiva se utiliza para definir una lista delimitada por comas de nombres cortos de los hosts "principales" para este 
host en particular. 
Los hosts principales suelen ser enrutadores, conmutadores, firewalls, etc. que se encuentran entre el host de monitoreo y 
los hosts remotos. 
Un enrutador, conmutador, etc. que esté más cerca del host remoto se considera el "padre" de ese host. 
Lea el documento "Determinación del estado y la accesibilidad de los hosts de red" que se encuentra aquí para obtener más 
información. 
Si este host está en el mismo segmento de red que el host que realiza el monitoreo (sin enrutadores intermedios, etc.), 
se considera que el host está en la red local y no tendrá un host principal. 
Deje este valor en blanco si el host no tiene un host principal (es decir, está en el mismo segmento que el host de Nagios). 
El orden en el que especifica los hosts principales no tiene ningún efecto sobre cómo se monitorean las cosas.

importance: 	
Esta directiva se utiliza para representar la importancia del host para su organización. 
La importancia se utiliza al determinar si se deben enviar notificaciones a un contacto. 
Si el valor de importancia del anfitrión más los valores de importancia de todos los servicios del anfitrión es mayor o igual 
a la importancia mínima del contacto, se notificará al contacto. 
Por ejemplo, puede establecer este valor y la importancia_mínima de los contactos de manera que se notifique a un administrador 
del sistema cuando un servidor de desarrollo falle, pero al CIO solo se le notificará cuando el servidor de base de datos de 
comercio electrónico de producción de la empresa esté inactivo. 
La importancia también podría usarse como criterio de clasificación al generar informes o para calcular la bonificación de un 
buen administrador del sistema. 
El valor de importancia por defecto es cero. 
En Nagios Core 4.0.0 a 4.0.3, esto se conocía como valor_hora pero ha sido reemplazado por importancia.

hostgroups: 	
Esta directiva se utiliza para identificar los nombres cortos de los grupos de hosts a los que pertenece el host. 
Varios grupos de hosts deben estar separados por comas. 
Esta directiva se puede utilizar como alternativa (o además) al uso de la directiva de miembros en las definiciones de 
grupos de host.

check_command: 	
Esta directiva se usa para especificar el nombre corto del comando que se debe usar para verificar si el host está activo 
o inactivo. Normalmente, este comando intentaría hacer ping al host para ver si está "vivo". 
El comando debe devolver un estado OK (0) o Nagios asumirá que el host está inactivo. 
Si deja este argumento en blanco, el host no será verificado activamente. 
Por lo tanto, Nagios probablemente siempre asumirá que el host está activo (puede aparecer en estado "PENDIENTE" 
en la interfaz web). 
Esto es útil si está monitoreando impresoras u otros dispositivos que se apagan con frecuencia. 
La cantidad máxima de tiempo que puede ejecutarse el comando de notificación está controlada por la opción host_check_timeout.

initial_state: 	
De forma predeterminada, Nagios asumirá que todos los hosts están en estado UP cuando se inicia. 
Puede anular el estado inicial de un host utilizando esta directiva. 
Las opciones válidas son: o = ARRIBA, d = ABAJO y u = INALCANZABLE.

max_check_attempts: 	
Esta directiva se usa para definir la cantidad de veces que Nagios reintentará el comando de verificación del host si devuelve 
cualquier estado que no sea OK. 
Establecer este valor en 1 hará que Nagios genere una alerta sin volver a intentar la verificación del host. 
Nota: Si no desea verificar el estado del host, aún debe configurarlo en un valor mínimo de 1. 
Para omitir la verificación del host, simplemente deje la opción check_command en blanco.

check_interval: 	
Esta directiva se utiliza para definir el número de "unidades de tiempo" entre comprobaciones periódicas programadas del host. 
A menos que haya cambiado la directiva intervalo_longitud del valor predeterminado de 60, este número significará minutos. 
Puede encontrar más información sobre este valor en la documentación de programación de cheques.

retry_interval: 	
Esta directiva se utiliza para definir el número de "unidades de tiempo" que se esperarán antes de programar una nueva 
verificación de los hosts. 
Los hosts se reprograman en el intervalo de reintento cuando han cambiado a un estado que no es UP. 
Una vez que el host haya reintentado max_check_attempts veces sin un cambio en su estado, volverá a estar programado a su 
velocidad "normal" según lo definido por el valor check_interval. 
A menos que haya cambiado la directiva intervalo_longitud del valor predeterminado de 60, este número significará minutos. 
Puede encontrar más información sobre este valor en la documentación de programación de cheques.

active_checks_enabled *: 	
Esta directiva se utiliza para determinar si las comprobaciones activas (ya sea programadas periódicamente o bajo demanda) de 
este host están habilitadas o no. Valores: 0 = deshabilitar comprobaciones de host activas, 1 = habilitar comprobaciones de 
host activas (predeterminado).

passive_checks_enabled *: 	This directive is used to determine whether or not passive checks are enabled for this host. Values: 0 = disable passive host checks, 1 = enable passive host checks (default).
check_period: 	This directive is used to specify the short name of the time period during which active checks of this host can be made.
obsess_over_host|obsess *: 	This directive determines whether or not checks for the host will be "obsessed" over using the ochp_command. Values: 0 = disabled, 1 = enabled (default).
check_freshness *: 	This directive is used to determine whether or not freshness checks are enabled for this host. Values: 0 = disable freshness checks, 1 = enable freshness checks (default).
freshness_threshold: 	This directive is used to specify the freshness threshold (in seconds) for this host. If you set this directive to a value of 0, Nagios will determine a freshness threshold to use automatically.
event_handler: 	This directive is used to specify the short name of the command that should be run whenever a change in the state of the host is detected (i.e. whenever it goes down or recovers). Read the documentation on event handlers for a more detailed explanation of how to write scripts for handling events. The maximum amount of time that the event handler command can run is controlled by the event_handler_timeout option.
event_handler_enabled *: 	This directive is used to determine whether or not the event handler for this host is enabled. Values: 0 = disable host event handler, 1 = enable host event handler.
low_flap_threshold: 	This directive is used to specify the low state change threshold used in flap detection for this host. More information on flap detection can be found here. If you set this directive to a value of 0, the program-wide value specified by the low_host_flap_threshold directive will be used.
high_flap_threshold: 	This directive is used to specify the high state change threshold used in flap detection for this host. More information on flap detection can be found here. If you set this directive to a value of 0, the program-wide value specified by the high_host_flap_threshold directive will be used.
flap_detection_enabled *: 	This directive is used to determine whether or not flap detection is enabled for this host. More information on flap detection can be found here. Values: 0 = disable host flap detection, 1 = enable host flap detection.
flap_detection_options: 	This directive is used to determine what host states the flap detection logic will use for this host. Valid options are a combination of one or more of the following: o = UP states, d = DOWN states, u = UNREACHABLE states.
process_perf_data *: 	This directive is used to determine whether or not the processing of performance data is enabled for this host. Values: 0 = disable performance data processing, 1 = enable performance data processing.
retain_status_information: 	This directive is used to determine whether or not status-related information about the host is retained across program restarts. This is only useful if you have enabled state retention using the retain_state_information directive. Value: 0 = disable status information retention, 1 = enable status information retention.
retain_nonstatus_information: 	This directive is used to determine whether or not non-status information about the host is retained across program restarts. This is only useful if you have enabled state retention using the retain_state_information directive. Value: 0 = disable non-status information retention, 1 = enable non-status information retention.
contacts: 	This is a list of the short names of the contacts that should be notified whenever there are problems (or recoveries) with this host. Multiple contacts should be separated by commas. Useful if you want notifications to go to just a few people and don't want to configure contact groups.
contact_groups: 	This is a list of the short names of the contact groups that should be notified whenever there are problems (or recoveries) with this host. Multiple contact groups should be separated by commas.
notification_interval: 	This directive is used to define the number of "time units" to wait before re-notifying a contact that this host is still down or unreachable. Unless you've changed the interval_length directive from the default value of 60, this number will mean minutes. If you set this value to 0, Nagios will not re-notify contacts about problems for this host - only one problem notification will be sent out.
first_notification_delay: 	This directive is used to define the number of "time units" to wait before sending out the first problem notification when this host enters a non-UP state. Unless you've changed the interval_length directive from the default value of 60, this number will mean minutes. If this directive is used notifications will be sent out after the next check is performed following the first_notification_delay time. If you set this value to 0, Nagios will start sending out notifications immediately.
notification_period: 	This directive is used to specify the short name of the time period during which notifications of events for this host can be sent out to contacts. If a host goes down, becomes unreachable, or recoveries during a time which is not covered by the time period, no notifications will be sent out.
notification_options: 	This directive is used to determine when notifications for the host should be sent out. Valid options are a combination of one or more of the following: d = send notifications on a DOWN state, u = send notifications on an UNREACHABLE state, r = send notifications on recoveries (OK state), f = send notifications when the host starts and stops flapping, and s = send notifications when scheduled downtime starts and ends. If you specify n (none) as an option, no host notifications will be sent out. If you do not specify any notification options, Nagios will assume that you want notifications to be sent out for all possible states. Example: If you specify d,r in this field, notifications will only be sent out when the host goes DOWN and when it recovers from a DOWN state.
notifications_enabled *: 	This directive is used to determine whether or not notifications for this host are enabled. Values: 0 = disable host notifications, 1 = enable host notifications.
stalking_options: 	This directive determines which host states "stalking" is enabled for. Valid options are a combination of one or more of the following: o = stalk on UP states, d = stalk on DOWN states, and u = stalk on UNREACHABLE states.
As of Core 4.4.0 you can use the N option to log event states when notifications are sent out.
More information on state stalking can be found here.
notes: 	This directive is used to define an optional string of notes pertaining to the host. If you specify a note here, you will see the it in the extended information CGI (when you are viewing information about the specified host).
notes_url: 	This variable is used to define an optional URL that can be used to provide more information about the host. If you specify an URL, you will see a red folder icon in the CGIs (when you are viewing host information) that links to the URL you specify here. Any valid URL can be used. If you plan on using relative paths, the base path will the the same as what is used to access the CGIs (i.e. /cgi-bin/nagios/). This can be very useful if you want to make detailed information on the host, emergency contact methods, etc. available to other support staff.
action_url: 	This directive is used to define an optional URL that can be used to provide more actions to be performed on the host. If you specify an URL, you will see a red "splat" icon in the CGIs (when you are viewing host information) that links to the URL you specify here. Any valid URL can be used. If you plan on using relative paths, the base path will the the same as what is used to access the CGIs (i.e. /cgi-bin/nagios/).
icon_image: 	This variable is used to define the name of a GIF, PNG, or JPG image that should be associated with this host. This image will be displayed in the various places in the CGIs. The image will look best if it is 40x40 pixels in size. Images for hosts are assumed to be in the logos/ subdirectory in your HTML images directory (i.e. /usr/local/nagios/share/images/logos).
icon_image_alt: 	This variable is used to define an optional string that is used in the ALT tag of the image specified by the <icon_image> argument.
vrml_image: 	This variable is used to define the name of a GIF, PNG, or JPG image that should be associated with this host. This image will be used as the texture map for the specified host in the statuswrl CGI. Unlike the image you use for the <icon_image> variable, this one should probably not have any transparency. If it does, the host object will look a bit wierd. Images for hosts are assumed to be in the logos/ subdirectory in your HTML images directory (i.e. /usr/local/nagios/share/images/logos).
statusmap_image: 	This variable is used to define the name of an image that should be associated with this host in the statusmap CGI. You can specify a JPEG, PNG, and GIF image if you want, although I would strongly suggest using a GD2 format image, as other image formats will result in a lot of wasted CPU time when the statusmap image is generated. GD2 images can be created from PNG images by using the pngtogd2 utility supplied with Thomas Boutell's gd library. The GD2 images should be created in uncompressed format in order to minimize CPU load when the statusmap CGI is generating the network map image. The image will look best if it is 40x40 pixels in size. You can leave these option blank if you are not using the statusmap CGI. Images for hosts are assumed to be in the logos/ subdirectory in your HTML images directory (i.e. /usr/local/nagios/share/images/logos).
2d_coords: 	This variable is used to define coordinates to use when drawing the host in the statusmap CGI. Coordinates should be given in positive integers, as they correspond to physical pixels in the generated image. The origin for drawing (0,0) is in the upper left hand corner of the image and extends in the positive x direction (to the right) along the top of the image and in the positive y direction (down) along the left hand side of the image. For reference, the size of the icons drawn is usually about 40x40 pixels (text takes a little extra space). The coordinates you specify here are for the upper left hand corner of the host icon that is drawn. Note: Don't worry about what the maximum x and y coordinates that you can use are. The CGI will automatically calculate the maximum dimensions of the image it creates based on the largest x and y coordinates you specify.
3d_coords: 	This variable is used to define coordinates to use when drawing the host in the statuswrl CGI. Coordinates can be positive or negative real numbers. The origin for drawing is (0.0,0.0,0.0). For reference, the size of the host cubes drawn is 0.5 units on each side (text takes a little more space). The coordinates you specify here are used as the center of the host cube. 
