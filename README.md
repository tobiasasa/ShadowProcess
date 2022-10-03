	  	
                            
                / _\ |__   __ _  __| | _____      __   / _ \_ __ ___   ___ ___  ___ ___ 
                \ \| '_ \ / _` |/ _` |/ _ \ \ /\ / /  / /_)/ '__/ _ \ / __/ _ \/ __/ __| 
                _\ \ | | | (_| | (_| | (_) \ V  V /  / ___/| | | (_) | (_|  __/\__ \__ \ 
                \__/_| |_|\__,_|\__,_|\___/ \_/\_/   \/    |_|  \___/ \___\___||___/___/
                      						created by Tobiasasa
                                
				        
## Disclaimer			
											
*Sientase libre de usar shadowprocess en cualquier equipo en el que tenga permiso de ejecutar software malicioso,
bajo ningun termino se permite ejecutar/usar shadowprocess en un ordenador en el cual no tenemos permisos para 
ejecutar malware, no solamente es ilegal sino que podríamos poner en peligro el equipo en cuestión.
Dado que el RAT necesita poder conectarse de forma remota, está permitiendo una persistencia de otros piratas
informáticos en la red puedan apuntar o incluso bruteforce.*

*El proposito de shadowprocess es enseñar a todo aquel de la comunidad de ciberseguridad los conceptos basicos del desarrollo de malware,
he comentado todo el codigo , haciendo este mas interpretable por cualquiera que este comenzando, asi que ¡no hay excusas!

El desarrrollo de malware es una habilidad escencial que a menudo se pasa por alto en el mundo de la seguridad, al investigar desarrollo 
de malware, los desarrolladores e investigadores de seguridad pueden comprender mejor como piensan los ciberdelincuentes, asi como 
aprender a desarrollar el suyo con fines de seguridad.
No me hago responsable del uso que le den al malware, construido unicamente con fines educativos.

## Requisitos:
| Victima | Atacante |
| --- | --- |
| Windows 10 | SSH |
|  | Python3 |
|  | Parrot or KaliLinux |

## ¿Que es ShadowProcess?
											
ShadowProcess es un RAT (**Herramienta de acceso remoto**) C2 (**command and control**), **realiza la conexión remota mediante ssh**, para facilitar la tarea
de adminsitración, shadowprocess.py se ejecuta a modo de panel de adinistrador para gestionar las conexiones y ordenadores de manera más
eficiente. Es capaz de conectarse de forma remota a la computadora de destino, cargas y descargas remotas de archivos, así como la ejecución de 
código todo a través de comandos de red y comunicación.


ShadowProcess **esta programado en powershell y bash haciendo este un muy buen candidato a ser indetectable, ya 
que todo ocurre normalmente dentro de windows y todos los cambios son realizado desde el powershell administrador, por lo cual 
sus capacidades de red avanzadas dificultan la detección de antivirus y firewalls estándar.**

ShadowProcess tiene multiples formas de infectar a una victima, la princial concierne una instalación de archivos por lotes.

Comenzamos con el archivo **initial.cmd el cual descargar en forma de administrador 2 archivos a la carpeta %startup%, el wget.cmd
y el installer.ps1.** El wget se encarga de saltearse el UAC, agregar a la lista de exclusiones de windows defender la carpeta %startup%, 
donde se descargar el installer (startup) y tambien agrega el directorio temporal a exclusiones, finalmente descargar y ejecutar el instalador.

![1](https://user-images.githubusercontent.com/25709702/193583623-cd863f74-542c-4697-a012-d1b10b43e972.png)

![epath](https://user-images.githubusercontent.com/25709702/193588622-fc6f4425-482d-4eb1-9649-33fc007cedf5.png)


El instalador crea un carpeta con nombre aleatorio dentro del **direcrotio %temp%**, la cual sera la carpeta **donde iran nuestros payloads**.

Posteriormente, agrega una entrada al registro de windows, para finalizar un usuario elevado con totales privilegios es creado en la 
maquina victima, este usuario esta oculto para cualquier usuario o administrador del sistema. 


![1](https://user-images.githubusercontent.com/25709702/193583684-c298e340-f191-4837-b556-327a49d7c72d.png)



![6](https://user-images.githubusercontent.com/25709702/193583722-46d912dc-76ee-457e-bb23-88d84ffbabbb.png)

**Todos los archivos de instalación y configuración se borran automaticamente 5 segundos luego de instalar**, y crear 
el usuario.


![2](https://user-images.githubusercontent.com/25709702/193584369-46ddfb31-ad87-4e4d-827d-a100ff969f79.png)


Ahora lo unico que tenemos que hacer es configurar nuestro super silencioso rat para atacar por ssh. Lo que tendremos que hacer es crear
un archivo .shp (**guardar un txt con extension .shp**) con el siguente formato:


![7](https://user-images.githubusercontent.com/25709702/193583856-c8ed3139-4b35-47a1-ab57-b80334a5eb73.png)



![14](https://user-images.githubusercontent.com/25709702/193583940-4b773f47-8838-4282-adf5-c732274701ca.png)



![15](https://user-images.githubusercontent.com/25709702/193583978-2c27c7b4-1e8d-467d-bbe3-3cbc363f514d.png)

¡H4PPY H4CK1NG!

