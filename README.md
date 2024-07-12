# Update GE-Proton

The script checks if you have the latest version of GE-Proton installed in your `$HOME/.steam/root/compatibilitytools.d/` directory. 
If the latest version is not found in the directory, the latest release is downloaded. 

## Script logic
1. The script checks what is the name of the lastest tar.gz on https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest
2. Checks if a directory for latest release exist under `$HOME/.steam/root/compatibilitytools.d/`
3. If it does not exist, the script will create a temporary working directory under `/tmp/proton-ge-custom/`. If it already exist the script just outputs that the latest proton version is installed. 
4. Download the latest tarball
5. Download checksum of latest tarball from https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest
6. Verify the tarball checksum
7. Create directory `$HOME/.steam/root/compatibilitytools.d/` if it does not exist
8. Extract the tarball from temporary working directory to `$HOME/.steam/root/compatibilitytools.d/`
9. Remove temporary working directory `/tmp/proton-ge-custom/`

