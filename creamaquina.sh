##!/bin/bash

#Creacion del disco virtual dinamico para la maquina
VBoxManage createhd --filename $1.vdi --size 10000

#Creacion de la maquina con su respectivo ostype
VBoxManage createvm --name $1 --ostype "Ubuntu" --register

#Creacion del controlador para el disco
VBoxManage storagectl $1 --name "SATA Controller" --add sata --controller IntelAHCI

#se pega el disco al controlador
VBoxManage storageattach $1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $1.vdi

#crea un controlador  para dispositivos de almacenamiento
VBoxManage storagectl $1 --name "IDE Controller" --add ide

# Habilida I/O APIC si esta disponible
VBoxManage modifyvm $1 --ioapic on

#Asigna el tamaño de memoria ram
VBoxManage modifyvm $1 --memory $2 

#Asigna un numero de nucleos para CPUs de la maquina virtual
VBoxManage modifyvm $1 --cpus $3

# Establece el orden de booteo
VBoxManage modifyvm $1 --boot1 dvd --boot2 disk --boot3 none --boot4 none

#configura la tarjeta de red de la memoria virtual
VBoxManage modifyvm $1 --nic1 bridged --bridgeadapter1 e1000g0

# Asigna memoria para la tarjeta grafica
VBoxManage modifyvm $1 --vram 128
