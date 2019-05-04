#!/usr/bash
#Ubunto 16.04

echo "\nBanco Shell Script"
echo -n "Informe seu usuário: "
read user

echo "\nBuscando informações..."
wget -q https://raw.githubusercontent.com/leandersonandre/shell-script/master/lista_usuarios.txt
result=$(cat lista_usuarios.txt | grep -w "$user")

if [ $result ]; then
    echo "\nUsuário encontrado.\nBaixando dados do usuário..."
    wget -qO- https://github.com/leandersonandre/shell-script/blob/master/$user.tar.gz?raw=true | tar -xz
    
    echo "Download completo"
    cd $user
    option=0
    
    while [ $option -ne 3 ]; do
        echo -n "\n\nSelecione uma opção:\n1. Ver Saldo\n2. Ver Extrato\n3. Sair\nDigite sua opção: "
        read option
        echo
        
        if [ $option -eq 1 ]; then
            cat saldo.txt
        elif [ $option -eq 2 ]; then
            cat extrato.txt
        elif [ $option -eq 3 ]; then
            echo "Excluindo arquivos..."
            cd ..
            rm -r lista_usuarios.txt $user
            echo "Obg, volte semppre\nBank Shell"
        else
            echo "Opção invalida"
        fi
    done
else
    echo "Usuário $user não encontrado\n"
    
    if [ lista_usuarios.txt ]; then
        rm lista_usuarios.txt
    fi
fi
