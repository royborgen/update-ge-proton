# Update GE-Proton

This script improves upon the original GE-Proton installation script by automating the update process and ensuring that only valid tarballs are installed. The script will download and install the latest version of GE-Proton only after checking and verifying that it is not already installed. 

## Script Logic

1. The script queries the latest tarball version from the GitHub API for GE-Proton.
2. It checks if the latest version is already installed in the `$HOME/.steam/root/compatibilitytools.d/` directory.
3. If the latest version is not installed, it creates a temporary working directory at `/tmp/proton-ge-custom/`.
4. Downloads the latest tarball and checksum for verification.
5. Verifies the checksum of the tarball, and continues with installation only if it matches.
6. Creates the necessary Steam directory `$HOME/.steam/root/compatibilitytools.d/` if it doesn’t exist.
7. Extracts the tarball into the Steam directory.
8. Cleans up by removing the temporary working directory `/tmp/proton-ge-custom/`.

## Key Improvements

- **Checksum Verification**: Ensures only valid tarballs are installed by verifying the checksum before proceeding.
- **Efficiency**: Avoids redundant downloads and installations by checking if the latest release is already installed.
- **Flexibility**: Uses variables for paths, allowing easier modification of directories and temporary folder locations.

I would like to thank **GloriousEggroll** for creating the original GE-Proton and for his ongoing contributions to Linux gaming. For more information, check out the [GE-Proton project on GitHub](https://github.com/GloriousEggroll/proton-ge-custom).

