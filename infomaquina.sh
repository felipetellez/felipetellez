#!/bin/bash
#INTEGRANTES:
#JUAN DANIEL GALARZA COD: 1323966
#JUAN FELIPE TELLEZ COD: 1331425
#CRISTIAN CAMILO JURADO COD: 1324366

#nucleos
VBoxManage showvminfo $1 | grep "Number of" | tr -s ' ' | cut -d' ' -f4

#tamaño memoria RAM
VBoxManage showvminfo $1 | grep Memory | tr -s ' ' | cut -d ' ' -f3

#numero de interfaces de red
VBoxManage showvminfo $1 | grep Attachment  | tr -s ' '| tr -d : | cut -d' ' -f2

#tipo de las interfaces de red
VBoxManage showvminfo $1 | grep Attachment  | tr -s ' '| tr -d , | cut -d' ' -f6



