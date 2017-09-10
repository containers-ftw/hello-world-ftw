%apprun zsh
    exec /bin/zsh $SINGULARITY_APPROOT/hello-world.zsh
%appfiles zsh
    data/hello-world.zsh
%appinstall zsh
    apt-get install -y zsh > /dev/null 2>&1
