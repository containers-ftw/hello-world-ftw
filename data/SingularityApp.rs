%apprun rust
    exec hello-world.rust
%appfiles rust
    data/hello-world.rs
%appinstall rust
    curl -f -L https://static.rust-lang.org/rustup.sh -O
    chmod u+x rustup.sh
    RUSTUP_PREFIX=$PWD ./rustup.sh
    bin/rustc hello-world.rs -o bin/hello-world.rust
