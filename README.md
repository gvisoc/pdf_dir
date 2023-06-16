# pdf_dir.sh
This is is a bash script over `pandoc` that converts all files in a directory, matching an extension, into PDF. 

By default, the output directory is the same directory where the original documents are found.

Optionally, a markdown parser can be applied.

## Usage
- Install `pandoc` and the relevant extensions for it to be able to write PDF your system. It is usually a TeX/LaTeX distribution (e.g.: BasicTeX on Mac). Check [pandoc](https://pandoc.org/installing.html) for options on this.
- Clone or download this repo as a zip, and unpack. 
- Open a Terminal at the directory you've unpacked the zip, and run:

```shell
$ ./pdf_dir.sh 
# converts all docx files into PDF, in the current directory
$ ./pdf_dir.sh -m -e txt 
# converts all txt files into PDF, in the current directory, interpreting
# their contents as Markdown
$ ./pdf_dir.sh -e odt -d ~/Documents/reports 
# converts all odt documents into PDF, in the document Documents/reports
# relative to the current user's home.
$ ./pdf_dir.sh -e odt -d ~/Documents/reports -o ~/Documents
# converts all odt documents into PDF, in the document Documents/reports 
# relative to the current user's home. Places the results in Documents, 
# relative to the current user's home
```

It's important to note that the PDF files will be left in the same directory where the original files are, unless a specific other directory is specified with the `-o` option.

The command has a help option (any invalid option will print the help text):

```shell
$ pdf_dir.sh -h
pdf_dir.sh: convert all documents in a directory to PDF.

USAGE: pdf_dir.sh [-e extension] [-d input dir.] [-o output dir.] [-m]
         -e extension: of the files to process, no dots (.) or wildcards,
                e.g.: docx. Optional, default: docx
         -d input dir.: directory to process.
                Optional, default: current directory
         -o output dir.: directory to store the PDF files.
                Optional, default: the input directory
         -m: applies markdown parser to input files

Examples:
         pdf_dir.sh -e txt
             # converts all txt files in current directory
             # to PDF
         pdf_dir.sh -e txt -m
             # Same, but intepreting the content as markdown
         pdf_dir.sh
             # converts all docx files in current directory
             # to PDF
         pdf_dir.sh -d ~/Downloads
             # converts all docx files in current user's
             # Download directory to PDF
         pdf_dir.sh -d ~/Downloads -o ~/Documents/out
             # converts all docx files in current user's
             # Download directory to PDF, placing the PDF
             # files in Documents/out (relative to current
             # user's home)

```

## Adding the script to the PATH
The best approach is to update the `PATH` environment variable to include the script, to be able to invoke it from anywhere in the system.

For macOS, edit the file `.zshrc` at your user directory. For that, open the terminal and run `nano .zshrc`. For Linux, edit the relevant file (`.zshrc`. `.bashrc`, `.profile`,... depending on your particular distribution).

If you have saved `pdf_dir.sh` to Applications/Scripts under your home directory, add the following line adapted to your case.
```bash
PATH="$HOME/Applications/Scripts:$PATH"
```

Save and close the file (for `nano`, use CTRL+O to save (confirm with return) and then CTRL+X to exit).

Otherwise, adapt the `$HOME/Applications/Scripts` part of the example to your case.

After making this modification, either reopen the terminal or *source* the changes by running `source .zshrc`, `source ~/.bashrc`, or the relevant file of your system --the one you've just changed.