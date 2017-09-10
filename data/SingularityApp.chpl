%apprun chapel
    exec $SINGULARITY_APPROOT/hello-world.chpl
%appfiles chapel
    data/hello-world.chpl hello-world.chpl
%appenv chapel
    CHPL_HOME=/scif/apps/chapel
    CHPL_HOST_PLATFORM=linux64
    PATH=$CHPL_HOME:$CHPL_HOME/linux64:$CHPL_HOME/util:$PATH
    export CHPL_HOME CHPL_HOST_PLATFORM PATH 
    CHPL_TASKS=fifo
    CHPL_MEM=cstdlib
    export CHPL_TASKS CHPL_MEM
%appinstall chapel
    wget https://github.com/chapel-lang/chapel/releases/download/1.15.0/chapel-1.15.0.tar.gz
    tar --strip-components=1 -zxf chapel-1.15.0.tar.gz
    . util/quickstart/setchplenv.sh
    make && make check
    mv bin/linux64/chpl bin/
    ./bin/chpl -o bin/hello-world.chpl hello-world.chpl
