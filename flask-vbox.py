#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
# Librerias requeridas para correr aplicaciones basadas en Flask
from flask import Flask, jsonify, make_response, request, abort
import subprocess

app = Flask(__name__)

# Este metodo retorna la lista de sistemas operativos soportados por VirtualBox
# Los tipos de sistemas operativos soportados deben ser mostrados al ejecutar 
# el comando
# curl -i http://localhost:5000/vms/ostypes
# Este es el codigo del item 1
@app.route('/vms/ostypes',methods = ['GET'])
def ostypes():
	output = subprocess.check_output(['VBoxManage', 'list', 'ostypes'])
	return output

# Este metodo retorna la lista de maquinas asociadas con un usuario al ejecutar
# el comando
# curl -i http://localhost:5000/vms
# Este es el codigo del item 2a
@app.route('/vms',methods = ['GET'])
def listvms():
	output = subprocess.check_output(['VBoxManage','list','vms'])
	return output

# Este metodo retorna aquellas maquinas que se encuentran en ejecucion al 
# ejecutar el comando
# curl -i http://localhost:5000/vms/running
# Este es el codigo del item 2b
@app.route('/vms/running',methods = ['GET'])
def runninglistvms():
	output = subprocess.check_output(['VBoxManage', 'list', 'runningvms'])
	return output

# Este metodo retorna las caracteristica de una maquina virtual cuyo nombre es
# ingresado por el usuario
@app.route('/vms/info/<vmname>', methods = ['GET'])
def vminfo(vmname):
	output = subprocess.check_output(['./infomaquina.sh', vmname])
	return output

#Este metodo se encarga de crear una maquina virtual con el nombre, el numero de nucleos y el tamaño de memoria que el
#usuario le ingrese
# - El item 4 deberá usar el método POST del protocolo HTTP
@app.route('/vms/crear' , methods = ['POST'])
def crear_maquina():
	
	maquina = {
		'tittle': request.json['tittle'],
		'memoria': request.json['memoria'],
		'nucleos': request.json['nucleos']
	}
	vname = maquina['tittle']
	memoria = maquina['memoria']
	nucleos = maquina['nucleos']	
	output = subprocess.check_output(['./creamaquina.sh', vname, memoria, nucleos ])
	
	return output

#Este metodo se encarga de ejecutar el script que elimina una maquina virtual cuyo nombre lo ingresa el usuario
# - El item 5 usa el metodo DELETE del protocolo HTTP
@app.route('/vms/eliminar' , methods = ['DELETE'])
def eliminar_maquina():
	
	maquina = {
		'tittle': request.json['tittle'],
	}

	vname = maquina['tittle']
		
	output = subprocess.check_output(['./borramaquina.sh', vname])
	return output

@app.errorhandler(404)
def not_found(error):
 return make_response(jsonify({'error': 'No se encontro informacion'}), 404)

if __name__ == '__main__':
        app.run(debug = True, host='0.0.0.0')
