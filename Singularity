BootStrap: docker
From: ubuntu:14.04

#
# singularity create --size 8000 helloworld.img
# sudo singularity bootstrap helloworld.img Singularity
#

%runscript

    echo "This container will say hello-world!"
    echo "The languages provided include:"
    tree /scif/apps

    echo "Type singularity --app <language> <container>.img help to see help

%post
    locale-gen "en_US.UTF-8"
    apt-get update && apt-get install -y wget vim curl unzip git build-essential python python-dev
    apt-get install -y cpp gcc g++

%labels
CONTAINERSFTW_TEMPLATE scif-apps
CONTAINERSFTW_COMPETITION_HOST containersftw
CONTAINERSFTW_COMPETITION_NAME hello-world-ftw
MAINTAINER Vanessasaur

%environment
# Here I have global variables for each app section to access
SCIF_METRICS=/scif/data/metrics.py
DEBIAN_FRONTEND=headless

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



%apprun chapel
    exec hello-world.chpl
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
  


%apprun clisp
    exec clisp $SINGULARITY_APPROOT/hello-world.clisp
%appfiles clisp
    data/hello-world.clisp
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
    mv clojure-1.8.0/clojure* bin



%apprun csh
    exec csh $SINGULARITY_APPROOT/hello-world.csh
%appfiles csh
    data/hello-world.csh
%appinstall clisp
    apt-get install -y csh



%apprun csharp
    exec mono $SINGULARITY_APPROOT/hello-world.exe
%appfiles csharp
    data/hello-world.cs
%appinstall csharp
    apt-get install -y mono-gmcs
    gmcs hello-world.cs


%apprun fsharp
    exec $SINGULARITY_APPROOT/hello-world.exe
%appfiles fsharp
    data/hello-world.fs
%appinstall fsharp
    apt-get install -y fsharp
    fsharpc hello-world.fs -o hello-world.exe



%apprun gfortran
    exec $SINGULARITY_APPROOT/hello-world.gfortran
%appfiles gfortran
    data/hello-world.f90
%appinstall gfortran
    apt-get install -y gfortran
    gfortran -o hello-world.gfortran hello-world.f90



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
    


%apprun groovy
    exec $SINGULARITY_APPROOT/hello-world.groovy
%appfiles groovy
    data/hello-world.groovy
%appinstall groovy
    apt-get install -y groovy


%apprun haskell
    exec $SINGULARITY_APPROOT/hello-world.haskell
%appfiles haskell
    data/hello-world.hs
%appinstall haskell
    apt-get install -y ghc
    ghc hello-world.hs -o hello-world.haskell



%apprun jade
    exec jade $SINGULARITY_APPROOT/hello-world.jade
%appfiles jade
    data/hello-world.jade
%appinstall jade
    apt-get install -y jade



%apprun java
    java $SINGULARITY_APPROOT/HelloWorld
%appfiles java
    data/HelloWorld.java
%appinstall java
    apt-get install -y openjdk-7-jdk
    javac HelloWorld.java
    

%apprun julia
    exec julia $SINGULARITY_APPROOT/hello-world.jl
%appfiles julia
    data/hello-world.jl
%appinstall julia
    apt-get install -y julia
    


%apprun latex
    detex $SINGULARITY_APPROOT/hello-world.tex
%appfiles latex
    data/hello-world.tex
%appinstall latex
    apt-get install -y make gcc flex
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/opendetex/opendetex-2.8.1.tar.bz2
    tar --strip-components=1 -xvjf opendetex-2.8.1.tar.bz2
    make
    install -c -m 775 -g staff -s detex

   
%apprun octave
    exec octave --no-gui --silent $SINGULARITY_APPROOT/hello-world.octave
%appenv octave
    DISPLAY=localhost:0.0
    export DISPLAY
%appfiles octave
    data/hello-world.octave
%appinstall octave
    apt-get install -y octave


%apprun pascal
    exec $SINGULARITY_APPROOT/hello-world
%appfiles pascal
    data/hello-world.pas
%appinstall pascal
    apt-get install -y fp-compiler
    fpc hello-world.pas


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


%apprun scala
    exec scala HelloWorld
%appfiles scala
    data/hello-world.scala
    data/hello-world.scala bin/hello-world.scala
%appinstall scala
    apt-get install -y scala
    scalac hello-world.scala
    mv HelloWorld* bin


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
    apt-get install -y zsh
