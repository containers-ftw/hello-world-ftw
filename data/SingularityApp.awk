%apprun awk
    exec awk -f $SINGULARITY_APPROOT/hello-world.awk
%appfiles awk
    data/hello-world.awk
