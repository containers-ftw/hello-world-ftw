%apprun csh
    exec csh $SINGULARITY_APPROOT/hello-world.csh
%appfiles csh
    data/hello-world.csh
%appinstall csh
    apt-get install -y csh
