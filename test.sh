#!/bin/sh

if [ ! -f "container.ftw" ] 
  then
    echo "Please generate container.ftw before running."
    echo "singularity create --size 8000 container.ftw"
    echo "sudo singularity bootstrap container.ftw Singularity"
    exit 0
else
   container=container.ftw
fi

if [ $# -eq 0 ]
    then
    TIME_LOG=$PWD/container-ftw.results
    else
    TIME_LOG=$1
fi

echo "Languages available include:"
for app in $(singularity apps $container)
    do
    echo $app
done

echo "Display running commands:"
for app in $(singularity apps $container)
    do
    echo "singularity run --app $app $container"
done

echo "Running for each language..."
for app in $(singularity apps $container)
    do
    singularity run --app $app $container
done


echo "Results will be written to ${TIME_LOG}"

export TIME='%C\t%E\t%K\t%I\t%M\t%O\t%P\t%U\t%W\t%X\t%e\t%k\t%p\t%r\t%s\t%t\t%w\n'
echo -e 'COMMAND\tELAPSED_TIME_HMS\tAVERAGE_MEM\tFS_INPUTS\tMAX_RES_SIZE_KB\tFS_OUTPUTS\tPERC_CPU_ALLOCATED\tCPU_SECONDS_USED\tW_TIMES_SWAPPED\tSHARED_TEXT_KB\tELAPSED_TIME_SECONDS\tNUMBER_SIGNALS_DELIVERED\tAVG_UNSHARED_STACK_SIZE\tSOCKET_MSG_RECEIVED\tSOCKET_MSG_SENT\tAVG_RESIDENT_SET_SIZE\tCONTEXT_SWITCHES' > $TIME_LOG

echo "Performing Tests"
for app in $(singularity apps $container)
    do
    /usr/bin/time -a -o $TIME_LOG singularity run --app $app $container >> $TIME_LOG
done

# Remove empty lines
sed -i '/^$/d' $TIME_LOG
