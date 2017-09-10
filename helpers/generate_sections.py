#!/usr/bin/env python

'''This script will generate modular "sections" for the singularity
   build recipe, and save as <specfile>.json to some output folder'''

from glob import glob
import sys
import os
import json


sections_folder = sys.argv[1]
outfile = "%s/sections.json" %(sections_folder)

sections = dict()
files = glob('%s/SingularityApp*' %sections_folder)

for section_file in files:
    section_name = os.path.basename(section_file).split('.')[-1]
    new_section = {'files':[]}
    sections[section_name] = new_section
    with open(section_file,'r') as filey:
        sections[section_name]['content'] = filey.read()
    input_files = [x for x in os.listdir(sections_folder) 
                   if x.endswith(section_name) 
                   and x != os.path.basename(section_file)]
    sections[section_name]['files'] = input_files 
    
with open(outfile, 'w') as filey:
    filey.writelines(json.dumps(sections, indent=4, separators=(',', ': ')))
