BootStrap: docker
From: ubuntu:14.04

#
# singularity create --size 8000 container.ftw
# sudo singularity bootstrap container.ftw Singularity
#

%runscript

    echo "This container will say hello-world (in dinosaur)!"
    echo "The languages provided include:"
    tree /scif/apps

    echo "Type singularity --app <language> <container> help to see help

%post
    locale-gen "en_US.UTF-8"
    apt-get update && apt-get install -y wget vim curl unzip git build-essential python python-dev
    apt-get install -y cpp gcc g++

%labels
CONTAINERSFTW_TEMPLATE scif-apps
CONTAINERSFTW_HOST containersftw
CONTAINERSFTW_NAME hello-world-ftw
MAINTAINER Vanessasaur

%environment
# Here I have global variables for each app section to access
DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

%apprun awk
    exec awk -f $SINGULARITY_APPROOT/hello-world.awk
%appfiles awk
    data/hello-world.awk


%apprun bash
    exec /bin/bash hello-world.bash
%appfiles bash
    data/hello-world.bash bin/hello-world.bash


%apprun c
    exec hello-world.c
%appfiles c
    data/hello-world.c hello-world.c
%appinstall c
    gcc hello-world.c -o bin/hello-world.c


%apprun cat
    exec cat $SINGULARITY_APPROOT/hello-world.cat
%appfiles cat
    data/hello-world.cat


%apprun cpp
    exec hello-world.cpp
%appfiles cpp
    data/hello-world.cpp
%appinstall cpp
    g++ hello-world.cpp -o bin/hello-world.cpp


%apprun clisp
    exec clisp $SINGULARITY_APPROOT/hello-world.clisp
%appfiles clisp
    data/hello-world.clisp
%appinstall clisp
    apt-get install -y clisp


%apprun csh
    exec csh $SINGULARITY_APPROOT/hello-world.csh
%appfiles csh
    data/hello-world.csh
%appinstall csh
    apt-get install -y csh



%apprun go
    exec hello-world.go
%appenv go
    GOROOT=/scif/apps/go
    export GOROOT
%appfiles go
    data/hello-world.go
%appinstall go
    wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    tar --strip-components=1 -zxf go1.8.3.linux-amd64.tar.gz
    bin/go build hello-world.go && mv hello-world bin/hello-world.go
    
    

%apprun julia
    exec julia $SINGULARITY_APPROOT/hello-world.jl
%appfiles julia
    data/hello-world.jl
%appinstall julia
    apt-get install -y julia
    
   
%apprun octave
    exec octave --no-gui --silent $SINGULARITY_APPROOT/hello-world.octave
%appenv octave
    DISPLAY=localhost:0.0
    export DISPLAY
%appfiles octave
    data/hello-world.octave
%appinstall octave
    apt-get install -y octave


%apprun perl
    exec perl6 $SINGULARITY_APPROOT/hello-world.pl
%appfiles perl
    data/hello-world.pl
%appinstall perl
    apt-get install -y perl6
    

%apprun python
    exec python $SINGULARITY_APPROOT/hello-world.py
%appfiles python
    data/hello-world.py
%appinstall python
    apt-get install -y python python-dev
    

%apprun R
    exec Rscript $SINGULARITY_APPROOT/hello-world.R
%appfiles R
    data/hello-world.R
%appinstall R
    apt-get install -y r-base


%apprun ruby
    exec ruby $SINGULARITY_APPROOT/hello-world.rb
%appfiles ruby
    data/hello-world.rb
%appinstall ruby
    apt-get install -y ruby


%apprun rust
    exec hello-world.rust
%appfiles rust
    data/hello-world.rs
%appinstall rust
    curl -f -L https://static.rust-lang.org/rustup.sh -O
    chmod u+x rustup.sh
    RUSTUP_PREFIX=$PWD ./rustup.sh
    bin/rustc hello-world.rs -o bin/hello-world.rust


%apprun tcsh
    exec tcsh $SINGULARITY_APPROOT/hello-world.tcsh
%appfiles tcsh
    data/hello-world.tcsh
%appinstall tcsh
    apt-get install -y tcsh


%apprun zsh
    exec /bin/zsh $SINGULARITY_APPROOT/hello-world.zsh
%appfiles zsh
    data/hello-world.zsh
%appinstall zsh
    apt-get install -y zsh > /dev/null 2>&1
