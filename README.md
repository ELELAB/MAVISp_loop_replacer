# Protein Structure Linker Modeling with Modeller

## Description
This Python script automates the process of replacing long loops in protein structures with shorter ones, using MODELLER. 

As input, it requires a protein structure model to be modified and information on the loops to be replaced. It is designed to replace a long loop with a shorter one, which is made of shorter snippets (start and end stretches) of the original loop. So for instance, if the sequence is something like:
```
       s          e
...LQFSRTNAMGSRGEGEDM...
```
where `s` and `e` mark loop start and end, we replace it with something like:

```
       s    e     
...LQFSRTNEGEDM...
```

so we just keep the first and last 3 residues of the loop. It should be noted that the rest of the structure is kept completely frozen, only the replaced loop is remodeled by this script.

## Requirements
  - Python >=3.7
  - [MODELLER software](https://salilab.org/modeller/)

## Setup
  - Ensure MODELLER and its dependencies are installed and accessible.
  - Have the paths for the FASTA file and PDB file ready.
  - Have the uniprot id of the protein ready. 

## Usage

  1. Running the Script
    - Execute the following command to generate the needed alignment file from the parsed fasta file and the loop set up for MODELLER and initiate the modeling process:  

```
loop_replacer -f <fasta_file> -u <uniprot_id> -l <loop_positions> -r <residue_adjustments> -m <number_of_models> -p <pdb_file> (--chain <protein_chain>) > final_create_model.log
```

    - Replace `<fasta_file>` with the path to your input FASTA file.
    - Replace `<uniprot_id>` with the uniprot id of the protein.
    - `<loop_positions>` should be specified in the format "start:end start:end ...", and it corresponds to the start and end positions of the loop to be replaced.
    - `<residue_adjustments>` should correspond to the loop positions in the format "add_start:add_end add_start:add_end ...". and it corresponds to the number of residue to be kept at the N and C-terminus of the loop, respectively
    - `<number_of_models>` specifies how many models to generate with MODELLER.
    - Replace `<pdb_file>` with the path to your input PDB file. 
    - `<protein_chain>` is an optional parameter to specify the chain of the protein (default is chain A).

  2. Output
    - The script will create:
      - An alignment file (`<uniprot_id>.ali`) for modeling.
      - Multiple model files (`<uniprot_id>.<num>.pdb`) based on the specified number of models.
    - Important Output: 
      - Log file (`final_create_model.log`) where errors, warnings, and a summary of successfully produced models are mentioned.
      - MODELLER Model Evaluation and suggested best predicted model summary.
      - Renumbered model files (`<uniprot_id>.<num>_renum.pdb`).
      - Remember that in the cancermuts step of MAVISp when we generate the mutlist we should define the range as two separate domains

Example
-------
See example directory for a full example. A typical command line looks like:

```
./loop_replacer -f Q9UPY3.fasta -u Q9UPY3 -l 1100:1288 1389:1546 -r 6:5 4:5 -m 5 -p ../Q9UPY3.pdb > test.log
```

