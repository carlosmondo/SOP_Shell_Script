#!/usr/bash

echo "Banco Shell Script"
echo -n "Informe seu usuário: "
read user

echo "Buscando informações..."
wget -q https://raw.githubusercontent.com/leandersonandre/shell-script/master/lista_usuarios.txt

result=`cat lista_usuarios.txt | grep $user`

if [ $result ]; then
  echo "Usuário $user encontrado."
  echo "Baixando dados do usuário..."
  wget -q https://github.com/leandersonandre/shell-script/blob/master/$user.tar.gz?raw=true
  echo "Download completo"
  mv $user.tar.gz?raw=true $user.tar.gz
  gzip -d $user.tar.gz
  tar -xvf $user.tar

  option=0
  while [ $option -ne 3 ]; do
    echo -n "Selecione uma opção: \n1. Ver Saldo \n2. Ver Extrato \n3. Sair \nDigite sua opção:"
    read option

    if [ $option -eq 1 ]; then
      cat saldo.txt
    elif [ $option -eq 2 ]; then
      cat extrato.txt
    elif [ $option -eq 3 ]; then
      echo "Excluindo arquivos..."
      rm saldo.txt
      rm extrato.txt
      rm lista_usuarios.txt
      rm -r $user
      
      echo "Obg, volte sempre"
      echo "Bank Shell"
    else 
      echo "Opção inválida."
    fi 
  done
else
  echo "Usuário $user não encontrado."
fi
