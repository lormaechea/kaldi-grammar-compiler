#!/usr/bash

GREEN=$'\e[1;32m';
BLUE=$'\e[1;36m';
NC=$'\e[0m';

process_G_FST() {

    echo -e "\n\t________________________________________________________";
    echo -e "${GREEN}\n\n\t\t\t******************************";
    echo -e "${GREEN}\t\t\t****** MAIN G GENERATION *****";
    echo -e "${GREEN}\t\t\t******************************\n";

    echo -e "${NC}\t-------------------------------------------------------------";
    echo -e "\tWE PROCEED TO THE FST GENERATION OF '$mainGFile'";
    echo -e "\t-------------------------------------------------------------\n";

    # Creation of the FST directory:
    mkdir mainFST;

    # Counter initialization:
    counter=0;

    while IFS= read -r line
        do
            # Extracting the disambiguation symbol:
            id=$(echo -e $line | cut -f1 -d' ' | tr -d '#');

            # A counter for naming the files:
            counter=$((counter+1));

            # We name our files:
            fileName=${counter};

            # We call the python script and generate the corresponding FST files:
            echo -e "--> PROCESSING... $line";
            python3 automaton.py $line > ./mainFST/$fileName.txt

        done < "$mainGFile"

    echo -e "${BLUE}\n\t*** The $counter FST files were successfully created! ***\n";

}


compile_G_FST() {

    echo -e "${NC}\n\t---------------------------------------------------------";
    echo -e "\tWE PROCEED TO THE FST COMPILATION OF THE RESULTING FILES";
    echo -e "\t---------------------------------------------------------\n";

    # We initialize the fileCounter:
    fileCounter=1;

    # We specify the extension:
    ext=".fst";

    # We count the number of input txt files:
    maxTXTFiles=$(ls ./mainFST/*txt | wc -l);

    for mainGFile in $(ls -v mainFST);
        do
            if [ $fileCounter -le $maxTXTFiles ]; then
                # We specify the output filename:
                outputFile=${fileCounter}${ext};

                # We proceed to the compilation:
                echo -e "--> COMPILING... $outputFile";
                fstcompile --isymbols=newWords.txt --osymbols=newWords.txt --keep_osymbols=true --keep_isymbols=true ./mainFST/$mainGFile ./mainFST/$outputFile;
                # fstdraw --portrait=true --isymbols=newWords.txt --osymbols=newWords.txt ./mainFST/$outputFile| dot -Tpng -Gsize=30,60  > ./mainFST/${fileCounter}.png;

                # Counter incrementation:
                fileCounter=$((fileCounter+1));
            fi
        done

    fileCounter=$((fileCounter-1));
    echo -e "${BLUE}\n\t**** The $fileCounter FST files were compiled! ****\n";

}


unify_G_FST() {
    
    echo -e "${NC}\n\t----------------------------------------------------";
    echo -e "\tWE PROCEED TO THE UNIFICATION OF THE COMPILED FILES";
    echo -e "\t----------------------------------------------------\n";

    # We count the number of input fst files:
    maxFSTFiles=$(ls ./mainFST/*fst|wc -l);

    # File counter initialization:
    fileCounter=2;

    # Temporal counters initialization:
    counterTMP1=1;
    counterTMP2=2;

    # We specify the prefix:
    tmp="tmp_";

    # And the extension:
    ext=".fst";

    # First temporal file format:
    tmpFile1=${tmp}${counterTMP1}${ext};

    # We proceed to the first union:
    fstunion ./mainFST/1.fst ./mainFST/2.fst ./mainFST/$tmpFile1;

    for file in $(ls -v ./mainFST)
        do
            if [ $fileCounter -lt $maxFSTFiles ] ; then
                # File counter incrementation:
                fileCounter=$((fileCounter+1));
                
                # We specify the naming format of the involved files:
                fstFile=${fileCounter}${ext};
                tmpFile1=${tmp}${counterTMP1}${ext};
                tmpFile2=${tmp}${counterTMP2}${ext};

                # We proceed to the union of the rest of FST files:
                echo -e "--> UNIFYING FST... fstunion $tmpFile1 $fstFile $tmpFile2";
                fstunion ./mainFST/$tmpFile1 ./mainFST/$fstFile ./mainFST/$tmpFile2;

                # We remove the now unnecessary tmp files:
                rm ./mainFST/${tmpFile1};

                # Temporal counters incrementation;
                counterTMP1=$((counterTMP1+1));
                counterTMP2=$((counterTMP2+1));
            fi
        done

    echo -e "\n\n\t---------------------------------";
    echo -e "\tWE KEEP FOLLOWING THE NEXT STEPS";
    echo -e "\t---------------------------------\n";

    # We move the last file into a fst file named G.fst:
    echo -e "--> RENAMING... ./mainFST/$tmpFile2 ./mainFST/G.fst\n";
    mv ./mainFST/$tmpFile2 ./mainFST/G.fst;

    # We later proceed to the following steps of epsilon removal:
    echo -e "--> EPSILON REMOVAL... fstrmepsilon ./mainFST/G.fst ./mainFST/G_eps.fst";
    fstrmepsilon ./mainFST/G.fst ./mainFST/G_eps.fst;

    # To the determinization:
    echo -e "--> DETERMINIZATION... fstdeterminize ./mainFST/G_eps.fst ./mainFST/G_det.fst";
    fstdeterminize ./mainFST/G_eps.fst ./mainFST/G_det.fst;

    # # And the final minimization:
    echo -e "--> MINIMIZATION... fstminimizeencoded ./mainFST/G_det.fst ./mainFST/G_min.fst";
    fstminimizeencoded ./mainFST/G_det.fst ./mainFST/G_minenc.fst;
    # fstdraw --portrait=true --isymbols=newWords.txt --osymbols=newWords.txt ./mainFST/G_minenc.fst| dot -Tpng -Gsize=30,60  > ./mainFST/G_minenc.png;

    echo -e "${BLUE}\n\n\t\t\t*************************************";
    echo -e "\t\t\t*** THE MAIN GRAMMAR WAS CREATED! ***";
    echo -e "\t\t\t*************************************\n${NC}";

}
