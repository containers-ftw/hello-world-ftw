#!/usr/bin/env python

'''This script an an example "post processing" step to
   parse all strace results into a common dataframe
'''

from glob import glob
from io import StringIO
from datetime import datetime
import pandas

import sys
import os
import re
import json

logs_folder = os.path.abspath(sys.argv[1])
files = glob('%s/strace*internal.log' %logs_folder)
labels = ['time', 'seconds', 'usecs/call', 'calls', 'errors']

def get_language(filename):
    return os.path.basename(os.path.splitext(filename)[0]).replace('strace-','').replace('-internal','')

languages = [get_language(x) for x in files]


def load_log(log_file):
    with open(log_file,'r') as filey:
        content = filey.read()
    lines,table = content.split('\n%')
    lines = lines.split('\n')
    table = table.split('\n')[2:-3]
    return lines,table


def update_times_table(df,table,language):
    for row in table:
        values = [r.strip() for r in row.split(' ') if r not in ['',None]]
        if len(values) == 5:
            values.insert(4,0)
        # Last value is syscall
        columns =['%s_%s' %(values[-1],x) for x in labels]
        df.loc[language,columns] = values[:-1]
        print(df.loc[language,columns])
    return df


def update_features_table(fdf, lines,language):
    for l in range(len(lines)):
        line = lines[l]
        try:
            features = parse_command(line)
        except:
            pass
        shared = [x for x in features if x in fdf.columns.tolist()]
        fdf.loc[language,shared] += 1
    return fdf


def parse_command(line):
    # Find timestamp, format HH:MM:SS, and remove from line
    timestamp = re.findall('\d{2}:\d{2}:\d{2}',line)[0]
    line = line.replace(timestamp,'').strip()
    if "()" in line:
        command,rest = line.split('()',1)
        features = []
    else:
        command = re.findall('.+[(].+[)]',line)[0].strip()
        rest = line.replace(command,'')
        command,features = command.split('(',1)
        features = [x.strip() for x in re.sub('"|\]|\[|[*]','',features).split(',')]
    return_code = "return-code_%s" %rest.replace('=','',1).strip()
    features.append(return_code)
    features.append(command)
    return features


# Get all extracted features first, so we can count

all_features = []
column_names = []
for log_file in files:
    language =  get_language(log_file)
    lines,table = load_log(log_file)
    for line in lines:
        try:
            features = parse_command(line)
        except:
            pass
        new_features = [x for x in features if x not in all_features]
        all_features = all_features + new_features
    # Derive column labels for times table
    for row in table:
        values = [r.strip() for r in row.split(' ') if r not in ['',None]]
        if len(values) == 5:
            values.insert(4,0)
        # Last value is syscall
        columns =['%s_%s' %(values[-1],x) for x in labels]
        column_names = column_names + columns

# Remove just memory addresses
features = [x for x in all_features if not x.startswith('0x')]

# and extracted features
fdf = pandas.DataFrame(0,index=languages,columns=features)

# Data frame of all time metrics
column_names = pandas.Series(column_names).unique().tolist()
df = pandas.DataFrame(0,columns=column_names,index=languages)

for log_file in files:
    language =  get_language(log_file)
    print('Parsing language %s' %language)
    lines,table = load_log(log_file)
    # First handle the pre-recorded table
    df = update_times_table(df, table, language)
    fdf = update_features_table(fdf, lines, language)

df.to_csv('%s/language-times.tsv' %logs_folder,sep='\t')
fdf.to_csv('%s/language-features.tsv' %logs_folder,sep='\t')
