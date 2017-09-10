%apprun c
    exec hello-world.c
%appfiles c
    data/hello-world.c hello-world.c
%appinstall c
    gcc hello-world.c -o bin/hello-world.c
