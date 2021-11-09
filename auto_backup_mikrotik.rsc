
/system script
add comment="Script para backup Di\E1rio" dont-require-permissions=no name=\
    backup owner=cpd policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global filename ([/system identity get name] . \"-\" . [([:pick [/system c\
    lock get date] ([:find [/system clock get date] \"/\"] + 1) [:find [/syste\
    m clock get date] \"/\" ([:find [/system clock get date] \"/\" ] +1)]] . \
    \".\" . [:pick [/system clock get date] 0 [:find [/system clock get date] \
    \"/\"]] . \".\" . [:pick [/system clock get date] ([:find [/system clock g\
    et date] \"/\" ([:find [/system clock get date] \"/\" ] +1)] + 1) ([:find \
    [/system clock get date] \"/\" ([:find [/system clock get date] \"/\" ] +1\
    )] + 5)])]);\r\
    \n\r\
    \n/system backup save name=\"\$filename\"\r\
    \n/export compact file=\"\$filename\"\r\
    \n\r\
    \n\r\
    \n/tool fetch address=IP_FTP src-path=\"\$filename.backup\" \\ user=USUARIO_FTP\
    mode=ftp password=SENHA_FTP dst-path=\"\$filename.backup\" upload=y\
    es\r\
    \n \r\
    \ndelay 5;\r\
    \n\r\
    \n/tool fetch address=IP_FTP src-path=\"\$filename.rsc\" user=USUARIO_FTP \
    mode=ftp password=SENHA_FTP dst-path=\"\$filename.rsc\" upload=yes\r\
    \n \r\
    \ndelay 10;\r\
    \n/file remove \"\$filename.backup\"\r\
    \ndelay 2;\r\
    \n/file remove \"\$filename.rsc\""


/system scheduler
add interval=1d name=Backup on-event="/system script run backup;" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=sep/01/2021 start-time=03:00:00
