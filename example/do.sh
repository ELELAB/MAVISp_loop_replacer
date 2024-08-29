#!/bin/bash

module load python

../loop_replacer -f test_data/Q9UPY3.fasta -u Q9UPY3 -l 1100:1288 1389:1546 -r 6:5 4:5 -m 1 -p test_data/Q9UPY3.pdb > final_create_model.log

