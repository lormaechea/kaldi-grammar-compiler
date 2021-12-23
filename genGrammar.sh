#!/bin/bash

###########################################################################################
# DESCRIPTION :    A Bash script that creates an Kaldi G.fst grammar.
# EXECUTION   :    bash genGrammar.sh --grammar=<grammar_file> --stage=<stage> --draw_graph=<yes|no>
###########################################################################################

# Module import:
. bashModules/fstGProcessing.sh --source-only 
. bashModules/fstSubGProcessing.sh --source-only 
. bashModules/fstReplace.sh --source-only 

for i in "$@"; do
  case $i in
    -g=*|--grammar=*)
      grammar="${i#*=}"
      shift
    ;;
    -s=*|--stage=*)
      stage="${i#*=}"
      shift
    ;;
    -d=*|--draw_graph=*)
      draw_graph="${i#*=}"
      shift
    ;;
    *)
      echo -e "** WRONG USAGE: bash $0 $@";
      echo -e "-- PLEASE TYPE: bash $0 --grammar=<grammar_file> --stage=<stage> --draw_graph=<yes|no>";
      exit 1;
    ;;
  esac
done

echo -e "-- GRAMMAR     = ${grammar}";
echo -e "-- STAGE       = ${stage}";
echo -e "-- DRAW GRAPH  = ${draw_graph}";


# Filename, no extension:
filename=$(echo "$grammar" | cut -f1 -d'.');

# Log location:
mkdir -p "logs";
exec > >(tee -i ./logs/${filename}File.log);
exec 2>&1;

mainGFile="${filename}_main_norm.txt";
subGFile="${filename}_sub_norm.txt";

if [ $stage -le 0 ]; then
  perl prepareGrammar.pl "${grammar}";
fi

if [ $stage -le 1 ]; then
  # First stage --> FST main grammar generation:
  process_G_FST;

  # Second stage --> We proceed to its compilation:
  compile_G_FST;

  # Final stage --> We unify the total series of FST into a single G.fst file:
  unify_G_FST;
fi

if [ $stage -le 2 ]; then
  # First stage --> FST subgrammars generation:
  process_subG_FST;

  # Second stage --> We proceed to its compilation:
  compile_subG_FST;

  # Third stage --> We rename the resulting files:
  rename_subG_FST;

  # Final stage --> We unify every subgrammar into a single FST file:
  unify_subG_FST;
fi

if [[ $stage -le 3 ]]; then
  # We end up replacing the non terminals symbols (found in the main grammar) 
  # for their corresponding terminals (in subgrammars):
  replace_FST;

  # Rearranging and cleaning files:
  clean_FST;
fi
