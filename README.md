# Hello World Scientific Filesystem

![img/containers-ftw.png](img/containers-ftw.png)

This is a Scientific Filesystem installed in a Singularity container, used to evaluate ~20 languages across different metrics for printing a simple "Hello World," in dinosaur-speak of course! You can use the Makefile to build, clean, and run the container, and we will walk through the commands here. In all of these commands, we name the container based on the environment variable `$CONTAINER` (set in the [Makefile](Makefile) as `hello-world`).

Build the container!

```
sudo singularity build hello-world Singularity
```

What applications are available?

```
./hello-world apps
```

Run the primary timing analysis.

```
/bin/bash test.sh hello-world
```
