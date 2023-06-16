#!/bin/sh

EXTENSION="docx"
WORKDIR=$(pwd)
MARKDOWN=0

function print_help {
    COMMAND=$(echo $0 | awk -F '/' '{print $NF}')
    echo -e "$COMMAND: convert all documents in a directory to PDF."
    echo -e "\nUSAGE: $COMMAND [-e extension] [-d directory] [-m]"
    echo -e "\t -e extension: of the files to process, no dots (.) or wildcards,\n\t\te.g.: docx. Optional, default: docx"
    echo -e "\t -d directory: directory to process. Optional, default: current directory"
    echo -e "\t -m: applies markdown parser to input files"
    echo -e "\nExamples:"
    echo -e "\t $COMMAND -e txt         #converts all txt files of current directory to PDF"
    echo -e "\t $COMMAND -e txt -m      #Same, but intepreting the content as markdown"
    echo -e "\t $COMMAND                #converts all docx files of current directory to PDF"
    echo -e "\t $COMMAND -d ~/Downloads #converts all docx files of current user's Download directory to PDF"
}


while getopts ":d:e:m" OPT; do
    case $OPT in 
        d) WORKDIR=$(realpath $OPTARG)
        ;;
        e) EXTENSION=$OPTARG
        ;;
        m) MARKDOWN=1
        ;;
        \?) print_help
        exit 1;
        ;;
    esac

    case $OPTARG in
        -*) if [[ $OPT != "m" ]]; then 
            $echo "ERROR: Option $OPT needs a valid argument"
            exit 1
        fi
        ;;
    esac
done

USERDIR=$(pwd)
if [[ -n $WORKDIR && -d $WORKDIR ]]; then
    cd $WORKDIR
fi

FILENAMES=$(ls *.${EXTENSION})

for FILE in $FILENAMES; do
    FILE_OUT="$(echo "$FILE" | awk -F '.' '{print $1}').pdf"
    if [[ $MARKDOWN -eq 0 ]]; then
        pandoc -o "$FILE_OUT" "$FILE"
    else
        pandoc -f markdown -o "$FILE_OUT" "$FILE"
    fi
    if [[ $? -ne 0 ]]; then
        echo "Error processing file $FILE";
        cd $USERDIR
        exit 1
    fi
done
cd $USERDIR
exit 0