# pdf_dir.sh
This is is a bash script over `pandoc` that converts all files in a directory, matching an extension, into PDF. 

The output directory is the same directory where the original documents are found.

Optionally, a markdown parser can be applied.

## Usage
- Install `pandoc` and the relevant extensions for it to be able to write PDF your system. It is usually a TeX/LaTeX distribution (e.g.: BasicTeX on Mac). Check [pandoc](https://pandoc.org/installing.html) for options on this.
- Clone or download this repo as a zip, and unpack. 
- Open a Terminal at the directory you've unpacked the zip, and run:

```
./pdf_dir.sh 
# converts all docx files into PDF, in the current directory
./pdf_dir.sh -m -e txt 
# converts all txt files into PDF, in the current directory, interpreting their contents as Markdown
./pdf_dir.sh -e odt -d ~/Documents/reports 
# converts all odt documents into PDF, in the document Documents/reports relative to the current user's home.
```

It's important to note that the PDF files will be left in the same directory where the original files are.

The command has a help option (any invalid option will print the help text):

```
$ pdf_dir.sh -h
pdf_dir.sh: convert all documents in a directory to PDF.

USAGE: pdf_dir.sh [-e extension] [-d directory] [-m]
	 -e extension: of the files to process, no dots (.) or wildcards,
		e.g.: docx. Optional, default: docx
	 -d directory: directory to process. Optional, default: current directory
	 -m: applies markdown parser to input files

Examples:
	 pdf_dir.sh -e txt         #converts all txt files of current directory to PDF
	 pdf_dir.sh -e txt -m      #Same, but intepreting the content as markdown
	 pdf_dir.sh                #converts all docx files of current directory to PDF
	 pdf_dir.sh -d ~/Downloads #converts all docx files of current user's Download directory to PDF
```

## Adding the script to the PATH
The best approach is to update the `PATH` environment variable to include the script, to be able to invoke it from anywhere in the system.

For macOS, edit the file `.zshrc` at your user directory. For that, open the terminal and run `nano .zshrc`. For Linux, edit the relevant file (`.zshrc`. `.bashrc`, `.profile`,... depending on your particular distribution).

If you have saved `pdf_dir.sh` to Applications/Scripts under your home directory, add the following line adapted to your case.
```
PATH="$HOME/Applications/Scripts:$PATH"
```

Save and close the file (for `nano`, use CTRL+O to save (confirm with return) and then CTRL+X to exit).

Otherwise, adapt the `$HOME/Applications/Scripts` part of the example to your case