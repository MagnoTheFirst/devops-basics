#!/bin/sh

echo 'tl-root                                                   = Verbindung zu proxmox server testlab mit user root'
echo 'tl-magno                                                  = Verbindung zu proxmox server testlab mit user magno'
echo 'whereis 							= Anzeige der Pfade zu relevanten ordnern'
echo 'gpull <directory> <branch> 				= cd git-directory, git pull'


echo "tl-root=ssh root@192.168.1.135"
echo "tl-magno=ssh magno@192.168.1.135"
echo "cheat=/home/magno/own_commands/cheat-sheet.sh"
echo "k=sudo microk8s kubectl"
echo "s=sudo "
echo "hg=history | grep"
echo "llg=ll | grep"
echo "whereis=/home/magno/own_commands/whereis.sh"
echo "how-to=/home/magno/own_commands/howto.sh"


