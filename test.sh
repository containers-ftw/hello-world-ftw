#!/bin/sh

if [ ! -f "container-ftw.img" ] 
  then
    echo "Please generate container.ftw before running."
    echo "singularity create --size 8000 container-ftw.img"
    echo "sudo singularity bootstrap container-ftw.img Singularity"
    exit 0
else
   container=container-ftw.img
fi

if [ $# -eq 0 ]
    then
    TIME_LOG=$PWD/container-ftw.results
    else
    TIME_LOG=$1
fi

echo ""
echo "Languages available include:"
for app in $(singularity apps $container)
    do
    echo $app
done

echo ""
echo "Display running commands:"
echo "###################################"
for app in $(singularity apps $container)
    do
    echo "singularity run --app $app $container"
done

echo ""
echo "Running for each language..."
echo "###################################"
for app in $(singularity apps $container)
    do
    singularity run --app $app $container
done


echo ""
echo "Results will be written to ${TIME_LOG}"

export TIME='%C\t%E\t%K\t%I\t%M\t%O\t%P\t%U\t%W\t%X\t%e\t%k\t%p\t%r\t%s\t%t\t%w\n'
echo -e 'COMMAND\tELAPSED_TIME_HMS\tAVERAGE_MEM\tFS_INPUTS\tMAX_RES_SIZE_KB\tFS_OUTPUTS\tPERC_CPU_ALLOCATED\tCPU_SECONDS_USED\tW_TIMES_SWAPPED\tSHARED_TEXT_KB\tELAPSED_TIME_SECONDS\tNUMBER_SIGNALS_DELIVERED\tAVG_UNSHARED_STACK_SIZE\tSOCKET_MSG_RECEIVED\tSOCKET_MSG_SENT\tAVG_RESIDENT_SET_SIZE\tCONTEXT_SWITCHES' > $TIME_LOG

echo ""
echo "Performing Tests"
echo "###################################"

for app in $(singularity apps $container)
    do
    /usr/bin/time -a -o $TIME_LOG singularity run --app $app $container >> $TIME_LOG
done

mkdir -p logs
for app in $(singularity apps $container)
    do
    sudo strace -u $USER -C -T -o logs/strace-$app.log singularity run --app $app $container
done

if [ ! -f "container-ftw.test" ] 
  then
    echo "Please generate container-ftw.test before running."
    echo "singularity create --size 8000 container-ftw.test"
    echo "sudo singularity bootstrap container-ftw.test Singularity.test"
    exit 0
else
   container=container-ftw.test
fi

for app in $(singularity apps $container)
    do
    singularity run --app $app $container logs/strace-$app-internal.log
done


# Remove empty lines
sed -i '/^$/d' $TIME_LOG

## Generate static output

# json of TIME_LOG to render into index.html
python helpers/generate_result.py $TIME_LOG 

# json of recipe to render sections folder into generate.html
python helpers/generate_sections.py assets/data

python helpers/parse_strace.py logs 
