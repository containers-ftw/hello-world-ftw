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
    exec awk -f hello-world.awk
%appfiles awk
    data/hello-world.awk bin/hello-world.awk



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
    exec cat hello-world.cat
%appfiles cat
    data/hello-world.cat bin/hello-world.cat


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
    exec clisp hello-world.clisp
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



%apprun csh
    exec csh hello-world.csh
%appfiles csh
    data/hello-world.csh bin/hello-world.csh
%appinstall clisp
    apt-get install -y csh



%apprun csharp
    exec mono hello-world.exe
%appfiles csharp
    data/hello-world.cs
%appinstall csharp
    apt-get install -y mono-gmcs
    gmcs hello-world.cs
    mv hello-world.exe bin/hello-world.exe



%apprun fsharp
    exec hello-world.exe
%appfiles fsharp
    data/hello-world.fs
%appinstall fsharp
    apt-get install -y fsharp
    fsharpc hello-world.fs -o hello-world.exe



%apprun gfortran
    exec hello-world.gfortran
%appfiles gfortran
    data/hello-world.f90
%appinstall gfortran
    apt-get install -y gfortran
    gfortran -o bin/hello-world.gfortran hello-world.f90



%apprun go
    exec hello-world.go
%appen go
    GOROOT=/scif/apps/go
    export GOROOT
%appfiles go
    data/hello-world.go
%appinstall go
    wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    tar --strip-components=1 -zxf go1.8.3.linux-amd64.tar.gz
    bin/go build hello-world.go && mv hello-world bin/hello-world.go
    


%apprun groovy
    exec hello-world.groovy
%appfiles groovy
    data/hello-world.groovy bin/hello-world.groovy
%appinstall groovy
    apt-get install -y groovy



%apprun haskell
    ghc hello-world.hs -o bin/hello-world.haskell
%appfiles haskell
    data/hello-world.hs
%appinstall haskell
    apt-get install -y ghc



%apprun jade
    exec jade hello-world.jade
%appfiles jade
    data/hello-world.jade bin/hello-world.jade
%appinstall jade
    apt-get install -y jade



%apprun java
    cd /scif/apps/java
    java HelloWorld
%appfiles java
    data/HelloWorld.java
%appinstall java
    apt-get install -y openjdk-7-jdk
    javac HelloWorld.java
    mv HelloWorld.class bin/HelloWorld.class



%apprun julia
    exec julia hello-world.jl
%appfiles julia
    data/hello-world.jl bin/hello-world.jl
%appinstall julia
    apt-get install -y julia
    


%apprun latex
    detex hello-world.tex
%appfiles latex
    data/hello-world.tex bin/hello-world.tex
%appinstall latex
    apt-get install -y make gcc flex
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/opendetex/opendetex-2.8.1.tar.bz2
    tar --strip-components=1 -xvjf opendetex-2.8.1.tar.bz2
    make
    install -c -m 775 -g staff -s detex bin


    
%apprun node
    node hello-world.js
%appfiles node
    data/hello-world.js
%appinstall node
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | NVM_DIR=$PWD PROFILE=/db bash
    NVM_DIR="/scif/apps/nvm"
    export NVM_DIR
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" > /dev/null 2>&1
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" > /dev/null 2>&1   
    nvm install node
    nvm use node
%appenv node
    NVM_DIR=/scif/apps/nvm


%apprun nim
    exec hello-world.nim
%appfiles nim
    data/hello-world.nim
%appinstall nim
    wget https://nim-lang.org/download/nim-0.17.0.tar.xz
    tar --strip-components=1 -xf nim-0.17.0.tar.xz
    sh build.sh
    bin/nim c koch
    ./koch tools
    ./install.sh bin 
    bin/nim compile hello-world.nim
    mv hello-world bin/hello-world.nim
   

%apprun octave
    exec octave --no-gui --silent hello-world.octave
%appenv octave
    DISPLAY=localhost:0.0
    export DISPLAY
%appfiles octave
    data/hello-world.octave bin/hello-world.octave
%appinstall octave
    apt-get install -y octave


%apprun ooc
    exec hello-world.ooc    
%appfiles ooc
    data/hello-world.ooc
%appinstall ooc
    git clone https://github.com/nddrylliog/rock.git rock
    cd rock
    make rescue
    mv * ../
    bin/rock hello-world.ooc
    mv hello-world.ooc bin/hello-world.ooc


%apprun pascal
    exec hello-world.pascal
%appfiles pascal
    data/hello-world.pas
%appinstall pascal
    apt-get install -y fp-compiler
    fpc hello-world.pas
    mv hello-world bin/hello-world.pas


%apprun perl
    exec perl6 hello-world.pl
%appfiles perl
    data/hello-world.pl bin/hello-world.pl
%appinstall perl
    apt-get install -y perl6
    

%apprun python
    exec python hello-world.py
%appfiles python
    data/hello-world.py bin/hello-world.py
%appinstall python
    apt-get install -y python python-dev
    

%apprun R
    exec Rscript hello-world.R
%appfiles R
    data/hello-world.R bin/hello-world.R
%appinstall R
    apt-get install -y r-base


%apprun ruby
    exec ruby hello-world.rb
%appfiles ruby
    data/hello-world.rb bin/hello-world.rb
%appinstall ruby
    apt-get install -y ruby


%apprun rust
    exec hello-world.rs
%appfiles rust
%appinstall rust
    curl -f -L https://static.rust-lang.org/rustup.sh -O
    chmod u+x rustup.sh
    RUSTUP_PREFIX=$PWD ./rustup.sh
    bin/rustc hello-world.rs -o bin/hello-world.rust


%apprun scala
    exec scala HelloWorld
%appfiles scala
    data/hello-world.scala
%appinstall scala
    apt-get install -y scala
    scalac hello-world.scala
    mv HelloWorld* bin


%apprun tcsh
    exec tsch hello-world.tcsh
%appfiles tcsh
    data/hello-world.tcsh bin/hello-world.tcsh
%appinstall tcsh
    apt-get install -y tcsh


%apprun zsh
    exec /bin/zsh hello-world.zsh
%appfiles zsh
    data/hello-world.zsh bin/hello-world.zsh
%appinstall zsh
    apt-get install -y zsh
