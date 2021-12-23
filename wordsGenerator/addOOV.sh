#!/usr/bash

###########################################################################
# DESCRIPTION    :    A Bash script that adds the OOV words to the 
#                     words.txt file and assigns them a corresponding id.
# EXECUTION     :     bash addOOV.sh <OOV_FILE>
#                     (But already executed inside genGrammar.sh)
###########################################################################

# We take words.txt as the default file:
dir="wordsGenerator";
fileWords="./${dir}/words.txt";

# Sorting and preparing the file:
fileWordsSort=$(cat ${fileWords}|cut -f1 -d' '|sort -fg|sed -e 's/ $//g'|sed '/^$/d');

# Back-up copy:
echo -e "$fileWordsSort" > "./${dir}/file1.txt";

# The file where the OOVs are found:";
fileOOV=$1;

# Sorting and preparing the file:
fileOOVSort=$(cat ${fileOOV}|sed -e 's/[()\|]/ /g'|tr -s ' '|tr ' ' '\n'|sed '/^$/d'|sort -fg|uniq);

# Back-up copy:
echo -e "$fileOOVSort" > "./${dir}/file2.txt";

# We find the absent words:
difference=$(diff "./${dir}/file1.txt" "./${dir}/file2.txt" | egrep "^>" | sed -e 's/^> //g');

# And proceed to the new file creation:
newWords="${fileWordsSort}\n${difference}";
echo -e "$newWords" | sort > "./${dir}/tmp.txt";

# We print the words with an id (make sure the first symbol is not #0, or else an error will appear):
awk '{print $0 " " i++}' "./${dir}/tmp.txt" | sort -u | sed -r 's/^#0 0$/<eps> 0/g' | sed -r 's/^<eps> ([^0]+)/#0 \1/g'> ./newWords.txt;
# awk '{print $0 " " i++}' "./${dir}/tmp.txt" | sort -u > ./newWords.txt;

export ROOTVAR=$(cat ./newWords.txt | egrep "#0" | cut -f2 -d' ' | tr -d '$');

# Removing the temporary files:
rm "./${dir}/file1.txt" "./${dir}/file2.txt" "./${dir}/tmp.txt";
