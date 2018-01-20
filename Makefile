CONTAINER=hello-world

build:
	sudo singularity build $(CONTAINER) Singularity

clean:
	rm -f $(CONTAINER)

run: clean build
	/bin/bash test.sh $(CONTAINER)
	
web: run
	cp -R data web/data
	singularity exec python /opt/generate_result.py logs/$(CONTAINER).results
	singularity exec python /opt/generate_sections.py web/data
	singularity exec python /opt/parse_strace.py logs
