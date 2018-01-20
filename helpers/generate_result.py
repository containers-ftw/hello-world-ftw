#!/usr/bin/env python

import sys
import pandas
import json

# container-ftw.results
result_input = sys.argv[1]
df=pandas.read_csv(result_input,sep='\t')
df=df.dropna()

output = {"data": df.to_dict(orient="records")}
output_file = 'docs/data.json'
with open(output_file, 'w') as filey:
    filey.writelines(json.dumps(output, indent=4, separators=(',', ': ')))
