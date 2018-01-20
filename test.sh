#!/bin/sh

usage() {
   echo "./test.sh <container>"
}

mkdir -p logs

if [ $# -eq 1 ]
    then
    container=$1
else
   usage
   exit 1
fi

TIME_LOG=logs/$container.results
STRACE_LOG=logs/strace-$container

echo ""
echo "Languages available include:"
for app in $(./$container apps)
    do
    echo $app
done

echo ""
echo "Display running commands:"
echo "###################################"
for app in $(./$container apps)
    do
    echo "./$container run $app"
done

echo "--quiet will be added to suppress extra output."
echo "./$container --quiet run $app"


echo ""
echo "Running for each language..."
echo "###################################"
for app in $(./$container apps)
    do
    if [ "$app" != "trace" ]
        then
        ./$container --quiet run $app
    fi   
done


echo ""
echo "Results will be written to ${TIME_LOG}"

export TIME='%C\t%E\t%K\t%I\t%M\t%O\t%P\t%U\t%W\t%X\t%e\t%k\t%p\t%r\t%s\t%t\t%w\n'
echo -e 'COMMAND\tELAPSED_TIME_HMS\tAVERAGE_MEM\tFS_INPUTS\tMAX_RES_SIZE_KB\tFS_OUTPUTS\tPERC_CPU_ALLOCATED\tCPU_SECONDS_USED\tW_TIMES_SWAPPED\tSHARED_TEXT_KB\tELAPSED_TIME_SECONDS\tNUMBER_SIGNALS_DELIVERED\tAVG_UNSHARED_STACK_SIZE\tSOCKET_MSG_RECEIVED\tSOCKET_MSG_SENT\tAVG_RESIDENT_SET_SIZE\tCONTEXT_SWITCHES' > $TIME_LOG

echo ""
echo "Performing Tests"
echo "###################################"

# Time metrics for the container

for app in $(./$container apps)
    do
    if [ "$app" != "trace" ]
        then
        /usr/bin/time -a -o $TIME_LOG ./$container --quiet run $app >> $TIME_LOG
    fi
done

# Running strace from outside container (not as useful)

echo ""
echo "Trace results will be written to ${STRACE_LOG}"

for app in $(./$container apps)
    do
    if [ "$app" != "trace" ]
        then
        sudo strace -u $USER -C -T -o ${STRACE_LOG}-$app.log ./$container --quiet run $app
    fi
done

# Running strace from inside the container (more useful) with a trace app

for app in $(./$container apps)
    do
    if [ "$app" != "trace" ]
        then
        ./$container run trace $app $PWD/${STRACE_LOG}-$app-internal.log
    fi
done

# Remove empty lines, and roar output
sed -i '/^$/d' $TIME_LOG
sed -i '/RaawwWWWWWRRRR!!/d' $TIME_LOG

## Generate tab separated files
python helpers/parse_strace.py logs

# Generate data.json for web visualization
python helpers/generate_result.py $TIME_LOG
