Nosso projeto consiste em um software de analise de ransomware por honeyfiles.

Instruções para instalação:

No seu terminal linux baixe os arquivos necessários com git clone:

~$ git clone https://github.com/erickroratome/Mushroom.git

Caso o git não estaja instalado:

~$ sudo apt install git

Após instalar dê permissão de execução para o "instalador.sh":

~$ sudo chmod +x ./Mushroom/instalador.sh

Execute o instalador com privilegios:

~$ sudo ./Mushroom/instalador.sh


Quando terminar a instalação, reinicie a máquina para subir os processos.


OBS:
Deixamos uma pasta com alguns ransomwares famosos no mercado para testar a solução.

para evitar problemas o .zip está com protejido com senha: "infected"