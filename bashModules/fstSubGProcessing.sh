#!/usr/bash

GREEN=$'\e[1;32m';
BLUE=$'\e[1;36m';
NC=$'\e[0m';

process_subG_FST() {

    echo -e "\n\t________________________________________________________";
    echo -e "${GREEN}\n\n\t\t\t*****************************";
    echo -e "${GREEN}\t\t\t****** SUB G GENERATION *****";
    echo -e "${GREEN}\t\t\t*****************************\n";

    echo -e "${NC}\t-------------------------------------------------------";
    echo -e "\tWE PROCEED TO THE FST GENERATION OF '$subGFile'";
    echo -e "\t-------------------------------------------------------\n";

    # Creation of the FST directory:
    mkdir subFST;

    # Counter initialization:
    counter=0;

    while IFS= read -r line
        do
            # Extracting the disambiguation symbol:
            id=$(echo -e $line | cut -f1 -d' ' | tr -d '#');

            # A counter for naming the files:
            counter=$((counter+1));

            # We name our files (with id):
            fileName=${id}-${counter};

            # We call the python script and generate the corresponding FST files:
            echo -e "--> PROCESSING... $line";
            python3 automaton.py $line > ./subFST/$fileName.txt

        done < "$subGFile"

    echo -e "${BLUE}\n\t*** The $counter FST files were successfully created! ***\n";

}


compile_subG_FST() {

    echo -e "${NC}\n\t---------------------------------------------------------";
    echo -e "\tWE PROCEED TO THE FST COMPILATION OF THE RESULTING FILES";
    echo -e "\t---------------------------------------------------------\n";

    # We initialize the fileCounter:
    fileCounter=1;

    # We specify the ext:
    ext=".fst";

    # We count the number of input txt files:
    maxTXTFiles=$(ls ./subFST/*txt | wc -l);

    for subGFile in $(ls -v subFST);
        do
            id=$(echo -e $subGFile | cut -f1 -d'.');

            # We create the convenient folders:
            folder=$(echo -e $id | cut -f1 -d'-');
            mkdir -p ./subFST/$folder;

            if [ $fileCounter -le $maxTXTFiles ]; then
                # We specify the output filename:
                outputFile=${id}${ext};

                # We proceed to the compilation:
                echo -e "--> COMPILING... $folder/$outputFile";
                fstcompile --isymbols=newWords.txt --osymbols=newWords.txt --keep_osymbols=true --keep_isymbols=true ./subFST/$subGFile ./subFST/$folder/$outputFile;

                # Counter incrementation:
                fileCounter=$((fileCounter+1));
            fi
        done

    fileCounter=$((fileCounter-1));
    echo -e "${BLUE}\n\t**** The $fileCounter FST files were compiled! ****\n";

}

rename_subG_FST() {

    echo -e "${NC}\n\t-------------------------------------------------";
    echo -e "\tWE PROCEED TO THE NAME NORMALIZATION OF THE FILES";
    echo -e "\t-------------------------------------------------\n";

    ext=".fst";

    for dir in ./subFST/*/; 
        do 
            counter=1;
            for file in $(ls -v $dir); 
                do 
                    # We define the new name:
                    newName=${counter}${ext};

                    # And so we change the name:
                    mv -v ./${dir}${file} ./${dir}${newName};

                    # Counter incrementation:
                    counter=$((counter+1));
                done; 
                echo -e "\n------------------------\n";
        done

    echo -e "${BLUE}\n\t**** The renaming of every single file was done!!! ****\n";

}


unify_subG_FST() {

    echo -e "${NC}\n\t----------------------------------------------------";
    echo -e "\tWE PROCEED TO THE UNIFICATION OF THE COMPILED FILES";
    echo -e "\t----------------------------------------------------\n";

    for dir in ./subFST/*/; 
        do 
            echo -e "PROCESSING $dir DIRECTORY...";
            idFolder=$(echo -e $dir|cut -f3 -d'/');

            # We count the number of input fst files:
            maxFSTFiles=$(ls $dir/*fst|wc -l);

            # File counter initialization:
            fileCounter=2;

            # Temporal counters initialization:
            counterTMP1=1;
            counterTMP2=2;

            tmp="tmp_"; # We specify the prefix
            ext=".fst"; # And the ext

            # First temporal file format:
            tmpFile1=${tmp}${counterTMP1}${ext};

            if [ $maxFSTFiles -eq 1 ]; then
                echo -e "--> ENDING UNIFICATION... cp ./${dir}1.fst ./${dir}${idFolder}${ext}";
                cp ./${dir}1.fst ./${dir}${idFolder}${ext};

            elif [ $maxFSTFiles -eq 2 ]; then
                echo -e "--> ENDING UNIFICATION... fstunion ./${dir}1.fst ./${dir}2.fst ./${dir}${idFolder}${ext}";
                fstunion ./${dir}1.fst ./${dir}2.fst ./${dir}${idFolder}${ext};
            else
                # We proceed to the first union:
                echo -e "--> UNIFYING... fstunion ./${dir}${counterTMP1}.fst ./${dir}${fileCounter}.fst ./${dir}${tmpFile1}";
                fstunion ./${dir}${counterTMP1}.fst ./${dir}${fileCounter}.fst ./${dir}${tmpFile1};
        
                for file in $(ls -v $dir); 
                    do 
                        if [ $fileCounter -lt $maxFSTFiles ] ; then
                            # File counter incrementation:
                            fileCounter=$((fileCounter+1));

                            # We specify the naming format of the involved files:
                            fstFile=${fileCounter}${ext};
                            tmpFile1=${tmp}${counterTMP1}${ext};
                            tmpFile2=${tmp}${counterTMP2}${ext};

                            # We proceed to the union of the rest of FST files:
                            echo -e "--> UNIFYING... fstunion ./${dir}$tmpFile1 ./${dir}$fstFile ./${dir}$tmpFile2";
                            fstunion ./${dir}$tmpFile1 ./${dir}$fstFile ./${dir}$tmpFile2;

                            # We remove the now unnecessary tmp files:
                            rm ./${dir}${tmpFile1};

                            # Temporal counters incrementation;
                            counterTMP1=$((counterTMP1+1));
                            counterTMP2=$((counterTMP2+1));
                        fi
                    done

                    # We move the last file into a fst file named G.fst:
                    echo -e "\nENDING UNIFICATION...\n--> RENAMING... ./${dir}${tmpFile2} ./${dir}${idFolder}${ext}";
                    mv ./${dir}${tmpFile2} ./${dir}${idFolder}${ext};

                fi

            # We later proceed to the following steps of epsilon removal:
            echo -e "--> EPSILON REMOVAL... fstrmepsilon ${dir}${idFolder}${ext} ${dir}${idFolder}_eps${ext}";
            fstrmepsilon ${dir}${idFolder}${ext} ${dir}${idFolder}_eps${ext};

            # To the determinization:
            echo -e "--> DETERMINIZATION... fstdeterminize ${dir}${idFolder}_eps${ext} ${dir}${idFolder}_det${ext}";
            fstdeterminize ./${dir}${idFolder}_eps${ext} ./${dir}${idFolder}_det${ext};

            # And the final minimization:
            echo -e "--> MINIMIZATION... fstminimizeencoded ${dir}${idFolder}_det${ext} ${dir}${idFolder}_min${ext}";
            fstminimizeencoded ./${dir}${idFolder}_det${ext} ./${dir}${idFolder}_minenc${ext};
            fstdraw --portrait=true --isymbols=newWords.txt --osymbols=newWords.txt ./${dir}${idFolder}_minenc${ext} | dot -Tpng -Gsize=30,60  > ./${dir}${idFolder}_minenc.png;

            echo -e "${BLUE}\n\t'${idFolder}' subGrammar was created!\n${NC}";
            echo -e "--------------------------------------------------------\n";

        done

    echo -e "${BLUE}\n\t\t***********************************************";
    echo -e "\t\t*** ALL THE SUB GRAMMAR FILES WERE CREATED! ***";
    echo -e "\t\t***********************************************\n${NC}";

}
