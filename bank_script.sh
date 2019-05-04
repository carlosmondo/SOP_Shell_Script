#!/usr/bash

echo "\nBanco Shell Script"
echo -n "Informe seu usuário: "
read user

echo "\nBuscando informações..."
wget -q https://raw.githubusercontent.com/leandersonandre/shell-script/master/lista_usuarios.txt
result=$(cat lista_usuarios.txt | grep -w "$user")

if [ $result ]; then
        echo "\nUsuário encontrado."
        echo "Baixando dados do usuário..."
        wget -q https://github.com/leandersonandre/shell-script/blob/master/$user.tar.gz?raw=true

        mv $user.tar.gz?raw=true $user.tar.gz
        tar -xf $user.tar.gz
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
                        rm -r lista_usuarios.txt $user.tar.gz $user
                else
                        echo "Opção invalida\nObg, volte semppre\nBank Shell"
                fi
        done
else
        echo "O usuário $user não encontrado\n"

        if [ lista_usuarios.txt ]; then
                rm lista_usuarios.txt
        fi
fi
