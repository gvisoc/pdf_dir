#!/bin/sh

EXTENSION="docx"
WORK_DIR=$(pwd)
MARKDOWN=0
OUTPUT_DIR=""
USER_DIR=$(pwd)

function print_help {
    COMMAND="$(echo $0 | awk -F '/' '{print $NF}')"
    echo -e "$COMMAND: convert all documents in a directory to PDF."
    echo -e "\nUSAGE: $COMMAND [-e extension] [-d directory] [-m]"
    echo -e "\t -e extension: of the files to process, no dots (.) or wildcards,\n\t\te.g.: docx. Optional, default: docx"
    echo -e "\t -d input_directory: directory to process. Optional, default: current directory"
    echo -e "\t -o output_directory: directory to store the PDF files.\n\t\tOptional, default: input directory"
    echo -e "\t -m: applies markdown parser to input files"
    echo -e "\nExamples:"
    echo -e "\t $COMMAND -e txt         #converts all txt files of current directory to PDF"
    echo -e "\t $COMMAND -e txt -m      #Same, but intepreting the content as markdown"
    echo -e "\t $COMMAND                #converts all docx files of current directory to PDF"
    echo -e "\t $COMMAND -d ~/Downloads #converts all docx files of current user's Download directory to PDF"
}


while getopts ":d:e:o:m" OPT; do
    case "$OPT" in
        d) WORK_DIR=$(realpath "$OPTARG")
        ;;
        e) EXTENSION="$OPTARG"
        ;;
        m) MARKDOWN=1
        ;;
        o) OUTPUT_DIR=$(realpath "$OPTARG")
        ;;
        \?) print_help
        exit 1;
        ;;
    esac

    case "$OPTARG" in
        -*) if [[ "$OPT" != "m" ]]; then 
            echo "ERROR: Option $OPT needs a valid argument"
            exit 2
        fi
        ;;
    esac
done

if [[ ! -n "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$WORK_DIR"
fi

if [[ -n "$WORK_DIR" && -d "$WORK_DIR" ]]; then
    cd "$WORK_DIR"
else
    echo "Error --the directory specified, $WORK_DIR, doesn't exist."
    exit 3
fi

if [[ ! -d "$OUTPUT_DIR" ]]; then
    echo "Error --the output directory specified, $OUTPUTDIR, doesn't exist"
    cd "$USER_DIR"
    exit 3
fi

FILENAMES=$(ls -1 *."$EXTENSION")


# This loop is explained in this answer from StackOverflow
# https://superuser.com/a/284226
while IFS= read -r FILE || [[ -n $FILE ]]; do
   FILE_OUT="$(echo "$FILE" | awk -F '.' '{print $1}').pdf"
    if [[ $MARKDOWN -eq 0 ]]; then
        pandoc -o "$OUTPUT_DIR/$FILE_OUT" "$FILE"
    else
        pandoc -f markdown -o "$OUTPUT_DIR/$FILE_OUT" "$FILE"
    fi
    if [[ $? -ne 0 ]]; then
        echo "Error processing file $FILE";
        cd $USER_DIR
        exit 4
    fi 
done < <(printf '%s' "$FILENAMES")

cd "$USER_DIR"
exit 0