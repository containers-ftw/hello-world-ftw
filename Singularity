BootStrap: docker
From: ubuntu:14.04

%runscript

    echo "This container will say hello-world!"
    echo "The languages provided include:"
    tree /scif/apps

    echo "Type singularity --app <language> <container>.img help to see help

%pre
   apt-get update && apt-get install -y wget vim curl unzip git python python-dev build-essential

%labels
CONTAINERSFTW_TEMPLATE scif-apps
CONTAINERSFTW_COMPETITION_HOST containersftw
CONTAINERSFTW_COMPETITION_NAME hello-world-ftw
MAINTAINER Vanessasaur

%environment
# Here I have global variables for each app section to access
SCIF_METRICS=/scif/data/metrics.py

%apprun env
#!/bin/sh
# This is a helper app to print an internal environment variable
exec printenv $@

%apphelp env
This application serves to print an environment variable in the
container. Example usage:

   singularity run --app env container.img SINGULARITY_APPNAME
   env


%apprun awk
    exec awk -f hello-world.awk
%appfiles awk
    data/hello-world.awk bin/hello-world.awk


%apprun bash
    exec /bin/bash hello-world.bash
%appfiles bash
    data/hello-world.bash bin/hello-world.bash


%apprun basic
    exec /bin/bash hello-world.basic
%appfiles basic
    data/hello-world.bas hello-world.bas
%appinstall basic
    apt-get install -y gcc-multilib g++-multilib
    apt-get install -y lib32ncurses5-dev
    apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxpm-dev
    wget https://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux/FreeBASIC-1.05.0-linux-x86_64.tar.gz
    tar -xzvf FreeBASIC-1.05.0-linux-x86_64.tar.gz
    ./FreeBASIC-1.05.0-linux-x86_64/install.sh -i $PWD
    bin/fbc hello-world.bas && mv hello-world bin/hello-world.basic


%apprun cpp
    exec hello-world.cpp
%appinstall cpp
    apt-get install -y g++
    g++ hello-world.cpp -o bin/hello-world.cpp
%appfiles cpp
    data/hello-world.cpp hello-world.cpp

%apprun c
    exec hello-world.c
%appinstall c
    apt-get install -y gcc
    gcc hello-world.c -o bin/hello-world.c
%appfiles c
    data/hello-world.c hello-world.c

%apprun chapel
    exec hello-world.chpl
%appfiles chapel
    data/hello-world.chpl hello-world.chpl
%appinstall chapel
    wget https://github.com/chapel-lang/chapel/releases/download/1.15.0/chapel-1.15.0.tar.gz
    tar --strip-components=1 -zxf chapel-1.15.0.tar.gz
    source util/quickstart/setchplenv.sh
    make && make check
    mv bin/linux64/* bin/
    bin/chpl -o bin/hello-world.chpl hello-world.chpl   
    

%apprun clisp
    exec hello-world.clisp
%appfiles clisp
    data/hello-world.clisp bin/hello-world.clisp
%appinstall clisp
    apt-get install -y clisp

%apprun clojure
    java -cp clojure-1.8.0.jar clojure.main hello-world.clj
%appfiles clojure
    data/hello-world.clj bin/hello-world.clj
%appinstall clojure
    apt-get install -y default-jre
    wget https://repo1.maven.org/maven2/org/clojure/clojure/1.8.0/clojure-1.8.0.zip
    unzip clojure-1.8.0.zip
    mv clojure-1.8.0/clojure-1.8.0* bin
