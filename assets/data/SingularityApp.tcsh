%apprun tcsh
    exec tcsh $SINGULARITY_APPROOT/hello-world.tcsh
%appfiles tcsh
    data/hello-world.tcsh
%appinstall tcsh
    apt-get install -y tcsh
