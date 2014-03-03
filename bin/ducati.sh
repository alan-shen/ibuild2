#!/bin/bash

TOP=`dirname ${0}`
BINPATH=${TOP}
PATCHPATH=${TOP}/patch
UTILITYPATH=${TOP}/utility

. ${TOP}/ENVCONF
. ${UTILITYPATH}/colordefine.sh

# make ibuild2 build process(integrate your configs in ibuild2 to your base line)
echo -e "${green}IBUILD2 PROCESS...${normal}"
SPEC_NAME=spec_w32_DUCATI.conf
echo -e "BASE=${red}${BASE_DIR}${normal}"
echo -e "WORK=${red}${PROD_DIR}${normal}"
echo -e "SPEC=${red}${SPEC_NAME}${normal}"
hb $BASE_DIR $PROD_DIR $SPEC_NAME $1 $2 $3 $4 $5 $6 $7 $8 $9
if [ $? == 0 ];then 
	pushd $BASE_DIR > /dev/null

	echo -e "${green}\n\n\nCLEAN HBTMP FILES IN WORK DIR${normal}"
	${UTILITYPATH}/clean_hbtmp.sh --path=${PROD_DIR}

	# apply a patch for ignore .svn in findleaves.py/find/grep
	echo -e "${green}\n\n\nSOME SPECIAL PATCH IN LOCAL${normal}"
	cp -rfv ${PATCHPATH}/platform_focaltech.c $BASE_DIR/kernel/arch/x86/platform/intel-mid/device_libs/platform_focaltech.c

	# create change list first(for that you can clean your base line quickly use script "restore_codebase.sh")
	echo -e "${green}\n\n\nGENERATE CHANGE LIST...${normal}"
	${BASE_DIR}/create_changelist.sh

	# build
	echo -e "${green}\n\n\nANDROID BUILD PROCESS ->${normal}"
	source build/envsetup.sh;lunch 19;START=`date`;make bootimage -j8;echo $START;date
	#${OUT}/lfstk/main.sh -p DUCATI

	popd > /dev/null
fi
