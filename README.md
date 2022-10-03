	  	
		  __ _               _                   ___                             
                / _\ |__   __ _  __| | _____      __   / _ \_ __ ___   ___ ___  ___ ___ 
                \ \| '_ \ / _` |/ _` |/ _ \ \ /\ / /  / /_)/ '__/ _ \ / __/ _ \/ __/ __| 
                _\ \ | | | (_| | (_| | (_) \ V  V /  / ___/| | | (_) | (_|  __/\__ \__ \ 
                \__/_| |_|\__,_|\__,_|\___/ \_/\_/   \/    |_|  \___/ \___\___||___/___/
                      						created by Tobiasasa
                                
				        
                             ##<[DISCLAIMER]>##
											
Sientase libre de usar shadowprocess en cualquier equipo en el que tenga permiso de ejecutar software malicioso,
bajo ningun termino se permite ejecutar/usar shadowprocess en un ordenador en el cual no tenemos permisos para 
ejecutar malware, no solamente es ilegal sino que podríamos poner en peligro el equipo en cuestión.
Dado que el RAT necesita poder conectarse de forma remota, está permitiendo una persistencia de otros piratas
informáticos en la red puedan apuntar o incluso bruteforce.

El proposito de shadowprocess es enseñar a todo aquel de la comunidad de ciberseguridad los conceptos basicos del desarrollo de malware,
he comentado todo el codigo , haciendo este mas interpretable por cualquiera que este comenzando, asi que ¡no hay excusas!
El desarrrollo ed malware es una habilidad escencial que a menudo se pasa por alto en el mundo de la seguridad.
Al investigar desarrollo de malware, los desarrolladores e investigadores de seguridad pueden comprender mejor como piensan los ciberdelincuentes, 
asi como aprender a desarrollar el suyo con fines de seguridad.
No me hago responsable del uso que le den al malware, es unicamente con fines educativos. 


                             ##<[¿Que es ShadowProcess?]>##
											
ShadowProcess es un RAT (Herramienta de acceso remoto) C2 (command and control), realiza la conexión remota mediante ssh, para facilitar la tarea
de adminsitración, he creado shadorpocess.py a modo de panel de adinistrador para gestionar las conexiones y ordenadores de manera más
eficiente.
Es capaz de conectarse de forma remota a la computadora de destino, cargas y descargas remotas de archivos, así como la ejecución de 
código todo a través de comandos de red y comunicación.
ShadowProcess emplea una cierta cantidad de ejecuciones de powershell y bash haciendo este un muy buen candidato a ser indetectable, ya 
que todo lo que ocurre como infección/amenaza ocurre dentro de windows, y desde el usuario administrador del sistema, por lo cual 
shadowprocess facilmente evade cualquier sistema de seguridad,

ShadowProcess tiene multiples formas de infectar a una victima, la princial concierne un archivo bat, incluida la instalación de archivos 
por lotes y el uso de herramientas como RubberDucky (script adapatado para este controlador).


Comenzamos con el archivo initial.cmd el cual descargar en forma de administrador 2 archivos a la carpeta %startup%, el wget.cmd
y el installer.ps1. El wget unicamente se encarga de saltearse el UAC, agregar a la lista de exclusiones de windows defender la carpeta, 
donde se descargar el installer (startup) y tambien agrega el directorio temporal a exclusiones, y finalmente ejecutar el instalador.
Sus capacidades de red avanzadas dificultan la detección de antivirus y firewalls estándar.

El instalador crea un carpeta con nombre aleatorio dentro de el direcrotio %temp%, la cual sera la carpeta donde iran nuestros payloads.
Posteriormente, agrega una entrada al registro, para finalizar la creación de un usuario elevado con totales privilegios es creado en la 
maquina victima, este usuario esta oculto para cualquier usuario o administrador del sistema, tiene acceso a todo el ordenador y una posicion
en la lista de administradores. 

Tanto el inicial.cmd, como el wget.cmd e installer.ps1 se borran automaticamente 5 segundos luego de instalar todos los componentes, y crear 
el usuario.


Ahora lo unico que tenemos que hacer es configurar nuestro super silencioso rat para atacar por ssh. Lo que tendremos que hacer es crear
un archivo .shp (shadow process) con el siguente fornato:

- IP VICTIMA (nos informara por smtp al correo, cuando encontremos una nueva victima)
- contraseña del usuario swadmin en ese ordenador. 
- Directorio donde entrar el ssh. 

Victima1.shp ejemplo: 

192.168.100.228
Test123$$!#
C:\Users

Guardamos el archivo como victima.sh y lo unico que es necesario ahora es establecer la conexión de la siguiente manera: 

python3 ./shadowprocess.py ./Victima1.shp

	  		
			__ _               _                   ___                             
                        / _\ |__   __ _  __| | _____      __   / _ \_ __ ___   ___ ___  ___ ___ 
                        \ \| '_ \ / _` |/ _` |/ _ \ \ /\ / /  / /_)/ '__/ _ \ / __/ _ \/ __/ __| 
                        _\ \ | | | (_| | (_| | (_) \ V  V /  / ___/| | | (_) | (_|  __/\__ \__ \ 
                        \__/_| |_|\__,_|\__,_|\___/ \_/\_/   \/    |_|  \___/ \___\___||___/___/

																	
				[=] Selecione numero de payload a usar [=]														 
			Payloads:
					[0] Remote console
					[1] Keylogger
					[2] Upload & Download files
					[3] Webcam & micro
					[4] Add registry
					[5] Turn on/off AV  & Windows defender
					[6] RDP	
					[7] More...	
					
SHELL@shprocess $ 0 


swadmin@192.168.100.228's password: Test123$$!#

Microsoft Windows [Versión 10.0.19044.1889]

(c) Microsoft Corporation. Todos los derechos reservados.

swadmin@DESKTOP-I03VIOH C:\Users\swadmin> ¡¡PWN3D!!												




                                
