#!/bin/bash
#BORRADO DE UNA MÁQUINA VIRTUAL VIRTUALBOX

#Desregistramos el disco duro:
VBoxManage storagectl $1 --name "SATA Controller" --remove

#removemos el controlador  para dispositivos de almacenamiento
VBoxManage storagectl $1 --name "IDE Controller" --remove

#Borramos la máquina de VirtualBox:
VBoxManage unregistervm $1 -delete

