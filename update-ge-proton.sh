#!/bin/sh

# Enable strict error handling
set -euo pipefail

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

# check if a directory matching the latest release exists
if [ -d "${install_dir}${dir_name}" ]; then
    echo "$dir_name is already installed"
else
    # download tarball
    # make temp working directory
    echo "Creating temporary working directory $temp_dir..."
    rm -rf $temp_dir
    mkdir $temp_dir
    cd $temp_dir

    echo "Downloading tarball: $tarball_name..."
    curl -# -L $tarball_url -o $tarball_name 

    # download checksum
    echo "Fetching checksum URL..."
    checksum_url=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
		       | grep browser_download_url | cut -d\" -f4 | grep .sha512sum)
    checksum_name=$(basename $checksum_url)
    echo "Downloading checksum: $checksum_name..."
    curl -# -L $checksum_url -o $checksum_name 

    # verify tarball with checksum
    echo "Verifying tarball $tarball_name with checksum $checksum_name..."
    sha512sum -c $checksum_name

    # make steam directory if it does not exist
    echo "Creating Steam directory $install_dir if it does not exist..."
    mkdir -p $install_dir

    # extract proton tarball to steam directory
    echo "Extracting $tarball_name to $install_dir"
    tar -xf $tarball_name -C $install_dir
    echo "Removing temporary working directory $temp_dir"
    rm -rf $temp_dir
    echo "Installed latest version $dir_name"
    echo "All done :)"
fi

