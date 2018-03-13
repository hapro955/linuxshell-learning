
#change subfolders
function changeSubFolder(){
	cd /$1/$2/$3
	sudo chmod 777 .
}

#dowload image in google
function dowloadImageInGoogle(){
	imageLink=$(wget --user-agent 'Mozilla/5.0' -qO - "https://www.google.com/search?q=ha&hs=V3R&channel=fs&tbm=isch" | sed 's/</\n</g' | grep '<img' | head -n"$1" | tail -n1 | sed 's/.*src="\([^"]*\)".*/\1/g')
	wget $imageLink 
}

#create parent directory
function createParentDirectory(){
	sudo mkdir -p /$1/$2/
}

#create subfolders
function createSubFolder(){
	sudo mkdir -p /$1/$2/$3
	cd /$1/$2/$3
	sudo chmod 777 .
}

#change parent directory
function changeCurrentDirectory(){
	cd /$1
	sudo chmod 777 .
} 

#delete folder
function deleteParentDirectoryAlreadyExists(){
	sudo rm -r $1
}

function getNameSubFolder(){
	createParentDirectory $currentDirectory $parentDirectory
	currentDate=$(date +%w)
	for((i=0;i<7;i++))
	do	
		countImage=$(expr $i + 2)
		countDate=$(($i - $currentDate +1))
		nameSubFolder=$(date -d"now + $countDate day" +"%Y-%m-%d")
		createSubFolder $currentDirectory $parentDirectory $nameSubFolder
		dowloadImageInGoogle $countImage 
	done
}

function clearOldDirIfExist() {
	link=$("/$currentDirectoryclear/$parentDirectory/")
	if [ -d $link];
	then
		changeCurrentDirectory $currentDirectory 
		deleteParentDirectoryAlreadyExists $parentDirectory
	fi
}

function checkParentDirectoryExists() {
	clearOldDirIfExist
	getNameSubFolder
}

echo "Enter the parent directory name: "
read parentDirectory
currentDirectory=$(pwd)

checkParentDirectoryExists





