#!/usr/bin/env python

'''This script will generate modular "sections" for the singularity
   build recipe, and save as <specfile>.json to some output folder'''

from glob import glob
import sys
import json


sections_folder = sys.argv[1]
outfile = "%s/sections.json" %(sections_folder)

sections = dict()
files = glob('%s/SingularityApp*' %sections_folder)

for section_file in files:
    section_name = os.path.basename(section_file).split('.')[-1]
    with open(section_file,'r') as filey:
        sections[section_name] = filey.read()
    
with open(outfile, 'w') as filey:
    filey.writelines(json.dumps(sections, indent=4, separators=(',', ': ')))
