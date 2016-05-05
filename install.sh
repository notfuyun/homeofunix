#!/bin/sh

. /etc/rc.d/init.d/functions

PACKAGE_NAME=Kanlc.tar.gz

curid=`id -u`
if [ "$curid" != "0" ]
then
	echo "Permission denied, Please use a root account"
	exit 1
fi

echo "Kingsoft Antivirus Network Linux Client Install Guide"
echo ""
echo "Copyright (c) 1998, 2004 Kingsoft Co., Ltd"
echo ""
echo "Thank you for choosing Kingsoft product."
echo ""
echo "This Install Guide will help you to install the King-"
echo "soft Antivirus Network Linux Client to your server."
echo ""
echo "Press <Enter> to continue..."
echo ""

read

cat LECENSE | more

echo -n "Do you Agree with above LECENSE(yes/no):" && read yon

if [ "$yon" != "yes" ] 
then
	echo ""
	echo -n "Do you want to exit install program(y/n)?" && read yon
	if [ "$yon" = "y" ]
	then
		exit 1
	fi
	./install.sh
	exit 0
fi

echo ""
echo -n "Checking for old product..."
if [ -e "/etc/Kingsoft/KANCSvc.conf" ]
then
	preInstallPath=`cat /etc/Kingsoft/KANCSvc.conf | sed "s:=: :g" | awk '/InstallPath/ && !/awk/ {print $2}'`
	if [ -d "$preInstallPath" ]
	then
		echo "You have installed Kingsoft Antivirus Network Linux Client on your computer,if you want to install it again ,please uninstall it before install again!"
		exit 1
	fi
else
	echo "OK"
	echo ""
fi

while :
do
	echo ""
	echo -n "Please input your install path:" && read szInstallPath
	count=`echo $szInstallPath | grep -c '^/'`
	if [ "$count" = "1" ]
	then
		if [ ! -d "$szInstallPath" ]
		then
			echo ""
			echo -n "Your input path: "$szInstallPath" does not exist, create it frist(y/n)?" && read yon
			if [ "$yon" = "y" ]
			then
				mkdir $szInstallPath
				if [ $? -ne 0 ] 
				then
					echo ""
					echo "Create Path "$szInstallPath" Error!"
				else
					break
				fi
			else
				echo ""
				echo "Do you want to exit install guide(y/n)?" && read yon
				if [ "$yon" = "y" ]
				then
					exit 1
				fi
			fi
		else
			end=`echo $szInstallPath | grep -c '/$'`
			if [ "$end" = "1" ]
			then
				szInstallPath="$szInstallPath""kavnet"
			else
				szInstallPath="$szInstallPath/kavnet"
			fi
			mkdir $szInstallPath
			break
		fi
	else
		echo ""
		echo "You have not input a valid path, please input an absolute path!"
	fi
done

szInstallLog="$szInstallPath""/install.log"

#
#tar
echo -n "Copying Files..."
tar zfx $PACKAGE_NAME -C $szInstallPath
if [ $? -ne 0 ]
then
	echo "Failed!"
	exit 1
else
	echo "OK."
fi

mkdir /var/lock/subsys
mv -f $szInstallPath/KANLinuxClient /etc/init.d/KANLinuxClient
#cat $szInstallPath/KANLinuxClient | sed "s:liixixi:$szInstallPath:g" > /etc/init.d/KANLinuxClient
#if [ $? -ne 0 ]
#then
#	echo ""
#	echo "Create KANLinuxClient file Failed!"
#	exit 1
#fi

chmod +x /etc/init.d/KANLinuxClient
chmod +x $szInstallPath/KANMainModule
chmod +x $szInstallPath/Kavdx
chmod +x $szInstallPath/Kavnet
chmod +x $szInstallPath/install.sh
chmod +x $szInstallPath/uninstall.sh
chmod +x $szInstallPath/UniUpdate
chmod +x $szInstallPath/KANLocalComm.so
chmod +x $szInstallPath/UniUpdateLogic.so


while :
do
	echo -n "Please input your System Center's IP Address:" && read ip
	addresscheck=`echo $ip | grep -c '^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$'`
	if [ $addresscheck -eq 1 ]
	then
		break
	fi
	echo ""
	echo "You have not input a valid IP Address!"
done

#$szInstallPath/KANCSvc.conf | sed "s:systemcenterip:$ip:g" > $szInstallPath/KANCSvc.conf
echo "Write system center ip to configure file" > $szInstallLog
sed "s:systemcenterip:$ip:g" $szInstallPath/KANCSvc.conf > $szInstallPath/KANCSvc.tmp
mv -f $szInstallPath/KANCSvc.tmp $szInstallPath/KANCSvc.conf
ls -s $szInstallPath/KANCSvc.conf >> $szInstallLog

echo ""
echo -n "Please input the Port which client listen(2002):" && read port

if [ -n "$port" ]
then
	#cat $szInstallPath/KANCSvc.conf | sed "s:2002:$port:g" > $szInstallPath/KANCSvc.conf
	sed "s:2002:$port:g" $szInstallPath/KANCSvc.conf > $szInstallPath/KANCSvc.tmp
	mv -f $szInstallPath/KANCSvc.tmp $szInstallPath/KANCSvc.conf
	ls -s $szInstallPath/KANCSvc.conf >> $szInstallLog
fi

#cat $szInstallPath/KANCSvc.conf | sed "s:localpath:$szInstallPath:g" > $szInstallPath/KANCSvc.conf
sed "s:localpath:$szInstallPath:g" $szInstallPath/KANCSvc.conf > $szInstallPath/KANCSvc.tmp
mv -f $szInstallPath/KANCSvc.tmp $szInstallPath/KANCSvc.conf
ls -s $szInstallPath/KANCSvc.conf >> $szInstallLog

SysVersion=`cat /etc/issue`
SysVersionNum=100

if test -n "$SysVersion"
then
	if TmpStr=`echo $SysVersion | grep -i "Red Hat Enterprise"` && test $? -eq "0"
	then
		SysVersionNum=101
	fi

        if TmpStr=`echo $SysVersion | grep -i "CentOS"` && test $? -eq "0"
        then
                SysVersionNum=102
        fi

        if TmpStr=`echo $SysVersion | grep -i "Fedora"` && test $? -eq "0"
        then
                SysVersionNum=103
        fi

        if TmpStr=`echo $SysVersion | grep -i "openSUSE"` && test $? -eq "0"
        then
                SysVersionNum=104
        fi

        if TmpStr=`echo $SysVersion | grep -i "Ubuntu"` && test $? -eq "0"
        then
                SysVersionNum=105
        fi

        if TmpStr=`echo $SysVersion | grep -i "Debian"` && test $? -eq "0"
        then
                SysVersionNum=106
        fi

        if TmpStr=`echo $SysVersion | grep -i "RedFlag"` && test $? -eq "0"
        then
                SysVersionNum=107
        fi
fi

sed "s:localversion:$SysVersionNum:g" $szInstallPath/KANCSvc.conf > $szInstallPath/KANCSvc.tmp
mv -f $szInstallPath/KANCSvc.tmp $szInstallPath/KANCSvc.conf
ls -s $szInstallPath/KANCSvc.conf >> $szInstallLog

if [ ! -d "/etc/Kingsoft" ]
then
	mkdir /etc/Kingsoft
	if [ $? -ne 0 ]
	then
		echo ""
		echo "Create /etc/Kingsoft Dir Failed"
		exit 1
	fi
fi

cp -f $szInstallPath/KANCSvc.conf /etc/Kingsoft

#
ln -sf /etc/init.d/KANLinuxClient /etc/rc0.d/K05KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc1.d/K05KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc2.d/K05KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc3.d/S90KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc4.d/S90KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc5.d/S90KANLinuxClient
ln -sf /etc/init.d/KANLinuxClient /etc/rc6.d/K05KANLinuxClient

ln -sf $szInstallPath/KANMainModule /usr/sbin/KANLinuxClient
#

ln -sf $szInstallPath/Kavdx /bin/Kavdx

szHostName=`hostname`
HasHostName=`cat /etc/hosts | grep -c $szHostName`
if [ "$HasHostName" = "0" ]
then
	echo 127.0.0.1 $szHostName `hostname -s` >> /etc/hosts
fi

rm -f /lib/kaescan.so
ln -s $szInstallPath/kaescan.so /lib/kaescan.so

ln -s $szInstallPath/Qtlib/libssl.so.6 /lib64/libssl.so.6
ln -s $szInstallPath/Qtlib/libcrypto.so.6 /lib64/libcrypto.so.6

echo ""
/etc/init.d/KANLinuxClient start
sleep 3
/etc/init.d/KANLinuxClient restart

echo "*/5 * * * * /bin/sh $szInstallPath/check_server.sh" > $szInstallPath/crontab_command

# Register/Unregister scheduled command
if [ -e $szInstallPath/crontab_command ]
then
		ftmp=$szInstallPath/tmp.crontab
		/usr/bin/crontab -l > $ftmp 2> /dev/null
		cat $szInstallPath/crontab_command >> $ftmp
		/usr/bin/crontab $ftmp
		/bin/rm -f $ftmp
fi

echo ""
echo "Congratulations! The Kingsoft Antivirus Network Linux Client has installed on your computer!"
echo ""
echo "Thank you for choosing Kingsoft product!"

exit 0
