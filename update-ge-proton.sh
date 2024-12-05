#!/bin/sh

# check latest tarball version
echo "Checking for update..."
tarball_url=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
	      | grep browser_download_url | cut -d\" -f4 | grep .tar.gz)
tarball_name=$(basename $tarball_url)
dir_name=${tarball_name%.*.*}
install_dir="$HOME/.steam/root/compatibilitytools.d/"
temp_dir="/tmp/proton-ge-custom/"

# informing the user what is the latest release
echo "Latest release is $dir_name"

# check if a directory matching the latest release exist) 
if [ -d "${install_dir}${dir_name}" ]; then
	echo "$dir_name is already installed"

    #if not, install new version 
    else
	# download tarball
    	# make temp working directory
    	echo "Creating temporary working directory $temp_dir..."
    	rm -rf $temp_dir
    	mkdir $temp_dir
    	cd $temp_dir
    	
	echo "Downloading tarball: $tarball_name..."
    	curl -# -L $tarball_url -o $tarball_name 2>&1

    	# download checksum
    	echo "Fetching checksum URL..."
    	checksum_url=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
		       | grep browser_download_url | cut -d\" -f4 | grep .sha512sum)
    	checksum_name=$(basename $checksum_url)
    	echo "Downloading checksum: $checksum_name..."
    	curl -# -L $checksum_url -o $checksum_name 2>&1

    	# verify tarball with checksum
	echo "Verifying tarball $tarball_name with checksum $checksum_name..."
	sha512sum -c $checksum_name
	checksum_status=$?  # Capture the exit status of the sha512sum command

	# If checksum verification fails, exit the script
	if [ $checksum_status -ne 0 ]; then
	    echo "Checksum verification failed for $tarball_name. Exiting."
	    rm -f $tarball_name $checksum_name
	    exit 1
	fi

    	# make steam directory if it does not exist
    	echo "Creating Steam directory $install_dir if it does not exist..."
    	mkdir -p $install_dir

    	# extract proton tarball to steam directory
    	echo "Extracting $tarball_name to $install_dir"
   	tar -xf $tarball_name -C $install_dir
    	echo "Removing temporary working directory $temp_dir"
    	cd
    	rm -rf $temp_dir
	echo "Installed latest version $dir_name"
    	echo "All done :)" 

fi
