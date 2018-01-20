CONTAINER=hello-world

build:
	sudo singularity build $(CONTAINER) Singularity

clean:
	rm -f $(CONTAINER)

run: clean build
	/bin/bash test.sh $(CONTAINER)
	
web: run
	python helpers/generate_result.py logs/$(CONTAINER).results
	python helpers/parse_strace.py logs
