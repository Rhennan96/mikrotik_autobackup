# mikrotik_autobackup
Script para backup automático Mikrotik

Substituir os campos IP_FTP, USUARIO_FTP , SENHA_FTP do script, ao todo serão 6 substituições, após ajutar o script, basta colar no terminal do equipamento que ele criará o script no sistema e a tarefa no sheduler.

As linhas 

/tool fetch address=IP_FTP src-path=\"\$filename.backup\" \\ user=USUARIO_FTP\
    mode=ftp password=SENHA_FTP dst-path=\"\$filename.backup\" upload=y\
   
 /tool fetch address=IP_FTP src-path=\"\$filename.rsc\" user=USUARIO_FTP \
    mode=ftp password=SENHA_FTP dst-path=\"\$filename.rsc\" upload=yes\r\

São responsáveis por enviar os arquivos de backup via FTP

As linhas
   
  file remove \"\$filename.backup\"\r\
    
  file remove \"\$filename.rsc\""
São responsáveis por deletar os arquivos após o envio via FTP, evitando que o armazenamento do dispositivo não lote.



Linha responsável por criar o agendamento para todo dia as 03:00:00 o script de backup ser executado

/system scheduler
add interval=1d name=Backup on-event="/system script run backup;" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=sep/01/2021 start-time=03:00:00
