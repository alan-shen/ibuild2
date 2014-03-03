#!/bin/bash

PRODUCT=$1
CONF=CONFIG_FEATURE_$PRODUCT.conf
COUNT=0

echo "================================== Check Droidboot =================================="
LIST=`cat ~/Desktop/droidboot/list`
for vlist in $LIST
do
	grep --color -nr $vlist $CONF
	if [ $? == 0 ];then
		COUNT=$((COUNT+1));
	fi
done
echo "------------------------------------ DROIDBOOT -------------------------------------"
cat ../DROIDBOOT/CONFIG_DROIDBOOT_$PRODUCT.conf | grep --color -nr "^IBUILD"
cat ../DROIDBOOT/CONFIG_DROIDBOOT_$PRODUCT.conf | grep --color -nr "^IBUILD" | wc -l
echo "================================== Check Recovery =================================="
LIST=`cat ~/Desktop/recovery/list`
for vlist in $LIST
do
	grep --color -nr $vlist $CONF
	if [ $? == 0 ];then
		COUNT=$((COUNT+1));
	fi
done
echo "------------------------------------ RECOVERY -------------------------------------"
cat ../RECOVERY/CONFIG_RECOVERY_$PRODUCT.conf | grep --color -nr "^IBUILD"
cat ../RECOVERY/CONFIG_RECOVERY_$PRODUCT.conf | grep --color -nr "^IBUILD" | wc -l
echo "===================================================================================="
echo "                                                                           Count=$COUNT"

