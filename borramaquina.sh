#!/bin/bash

#INTEGRANTES:
#JUAN DANIEL GALARZA COD: 1323966
#JUAN FELIPE TELLEZ COD: 1331425
#CRISTIAN CAMILO JURADO COD: 1324366

#BORRADO DE UNA MÁQUINA VIRTUAL VIRTUALBOX

#Desregistramos el disco duro:
VBoxManage storagectl $1 --name "SATA Controller" --remove

#removemos el controlador  para dispositivos de almacenamiento
VBoxManage storagectl $1 --name "IDE Controller" --remove

#Borramos la máquina de VirtualBox:
VBoxManage unregistervm $1 -delete

