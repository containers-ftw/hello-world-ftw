%apprun R
    exec Rscript $SINGULARITY_APPROOT/hello-world.R
%appfiles R
    data/hello-world.R
%appinstall R
    apt-get install -y r-base
