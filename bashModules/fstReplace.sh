#!/usr/bash

GREEN=$'\e[1;32m';
BLUE=$'\e[1;36m';
NC=$'\e[0m';

replace_FST() {

    echo -e "\n\t________________________________________________________";
    echo -e "${GREEN}\n\n\t\t\t*****************************";
    echo -e "${GREEN}\t\t\t****** REPLACING STAGE ******";
    echo -e "${GREEN}\t\t\t*****************************\n${NC}";

    # We create a specific folder for the fstreplace commands:
    repFolder="replaceFST";
    mkdir -p "$repFolder";

    # We select the variable ids:
    stringDollars=$(cat newWords.txt | egrep '\$' | tr -d '\$' | tr '\n' ',');

    # And save them into a list:
    IFS=',' read -a listDollars <<< "$stringDollars";

    # We create a list for the directories:
    declare -a folders
    iFold=1
    for folder in */*/; 
        do
            folders[iFold++]="${folder%/}"; 
        done

    # We specify the naming form:
    tmpCounter1=1;
    tmpCounter2=2;
    prefix="tmp_";
    extension=".fst";

    tmpFile1=${prefix}${tmpCounter1}${extension};
    tmpFile2=${prefix}${tmpCounter2}${extension};

    # We extract the root ID:
    rootID=$(cat newWords.txt | egrep "#0" | cut -f2 -d' ');

    #------------------------------------------------------

    # Backup copy (to initialize):
    cp ./mainFST/G_det.fst ./${repFolder}/finalG_det.fst;
    echo -e "--> INITIALIZING... cp ./mainFST/G_det.fst ./${repFolder}/finalG_det.fst";

    #------------------------------------------------------

    while fstprint ./${repFolder}/finalG_det.fst | egrep '\$' > /dev/null;
        do
            for folder in "${folders[@]}"
                do
                    folderName=$(echo $folder | cut -f2 -d'/');
                    # echo "$folderName";

                    for dollar in "${listDollars[@]}"
                        do
                            cle=$(echo $dollar | cut -f1 -d' ');
                            val=$(echo $dollar | cut -f2 -d' ');

                            if [[ "${cle}" = "${folderName}" ]]; then

                                tmpFile1=${prefix}${tmpCounter1}${extension};
                                tmpFile2=${prefix}${tmpCounter2}${extension};

                                if [ $tmpCounter1 -eq 1 ]; then
                                    echo -e "--> REPLACING... fstreplace --epsilon_on_replace ./mainFST/G_det.fst $rootID ./subFST/${cle}/${cle}_minenc.fst $val ./$repFolder/$tmpFile2";
                                    fstreplace --epsilon_on_replace ./mainFST/G_det.fst $rootID ./subFST/${cle}/${cle}_minenc.fst $val ./$repFolder/$tmpFile2;
                                else
                                    #echo "KEY ---> $cle | VALUE ---> $val";
                                    echo -e "--> REPLACING... fstreplace --epsilon_on_replace ./$repFolder/$tmpFile1 $rootID ./subFST/${cle}/${cle}_minenc.fst $val ./$repFolder/$tmpFile2";
                                    fstreplace --epsilon_on_replace ./$repFolder/$tmpFile1 $rootID ./subFST/${cle}/${cle}_minenc.fst $val ./$repFolder/$tmpFile2;

                                    # We remove the now unnecessary tmp files:
                                    rm ./${repFolder}/${tmpFile1};
                                fi

                            # Counter incrementation:
                            tmpCounter1=$((tmpCounter1+1));
                            tmpCounter2=$((tmpCounter2+1));

                            fi
                        done
                    done
                    
                    echo -e "\n---------------------------------------------------\n";
                    echo -e "--> ENDING LOOP... cp ./$repFolder/$tmpFile2 ./$repFolder/finalG.fst";
                    cp ./$repFolder/$tmpFile2 ./$repFolder/finalG.fst;

                    # We later proceed to the following steps of epsilon removal:
                    echo -e "--> EPSILON REMOVAL... fstrmepsilon ./$repFolder/finalG.fst ./$repFolder/finalG_eps.fst";
                    fstrmepsilon ./$repFolder/finalG.fst ./$repFolder/finalG_eps.fst;
                    
                    # To the determinization:
                    echo -e "--> DETERMINIZATION... fstdeterminize ./$repFolder/finalG_eps.fst ./$repFolder/finalG_det.fst";
                    fstdeterminize ./$repFolder/finalG_eps.fst ./$repFolder/finalG_det.fst;
                done

    # We remove the now unnecessary tmp files:
    rm -r ./${repFolder}/tmp_*;

    # And the final minimization:
    echo -e "\n\n----------------------------------------------------"
    echo -e "\nFINAL STAGE...";
    echo -e "--> MINIMIZATION... fstminimizeencoded ./$repFolder/finalG_det.fst ./$repFolder/finalG_minenc.fst";
    fstminimizeencoded ./$repFolder/finalG_det.fst ./$repFolder/finalG_minenc.fst;

    echo -e "--> SORTING... fstarcsort ./$repFolder/finalG_det.fst ./$repFolder/finalG_minenc.fst";
    fstarcsort ./$repFolder/finalG_minenc.fst ./$repFolder/G.fst;

    case "$draw_graph" in 
        yes)
         fstdraw --portrait=true --isymbols=newWords.txt --osymbols=newWords.txt ./$repFolder/G.fst | dot -Tpng -Gsize=60,60  > ./$repFolder/G.png;
        ;;
        no)
         echo "--> No graph was drawn.";
        ;;
    esac

    echo -e "${GREEN}\n\n\t\t******************************************************";
    echo -e "\t\t*** NOW THE FINAL GRAMMAR 'G.fst' IS READY TO USE! ***";
    echo -e "\t\t******************************************************\n\n${NC}";

}


clean_FST () {

    mkdir -p "${filename}FST";
    mv mainFST/ subFST/ replaceFST/ "${filename}FST";
    cp -r "${filename}FST"/replaceFST/G* "${filename}FST";

}
