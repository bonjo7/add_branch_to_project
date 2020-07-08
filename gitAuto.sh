#!/bin/bash
apps_file=$1

if [[ "$apps_file" == "" ]]; then echo "please provide the name of the file"; exit 1; fi
if [[ ! -f $apps_file ]]; then echo "$apps_file file not found"; exit 1; fi

header=true
linenum=1

copy="cp -R ../nodeApp/* .";
createBranch="git checkout -b stopped";
gitMessage="git commit -m \"Created stopped branch\"";
gitPush="git push origin/stopped";

while IFS=, read git_url

do

	if [[ "$header" == "true" ]]; then header=false; continue; fi
    
	((linenum++));
		
		gitClone(){
			echo "Cloning $git_url";
		}
		
		changeDirectory(){
			git clone "$git_url" && cd "$(ls -t | head -1)";
			echo "*** Current files ***";
			ls -a;
		}

		gitCreateBranch(){
			echo "Creating branch from command: $createBranch";
			$createBranch;
		}

		removeAndCopyFiles(){
			echo "Removing and copying files from command: $copy";
			rm -rf *;
			$copy;
			echo "*** Newly copied files ***";
			ls -a;
		}

		gitAddAndPush(){
			echo "And and commit changes with commit message: $gitMessage";
			git add .;
			$gitMessage;
			$gitPush;
			cd ..;
		}

		gitClone;
		changeDirectory;
		gitCreateBranch;
		removeAndCopyFiles;
		gitAddAndPush;

done < $apps_file


