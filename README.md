# Update GE-Proton

This script improves upon the original GE-Proton installation script by automating the update process and ensuring that unnecessary installations are avoided. The script will download and install the latest version of GE-Proton only if it is not already installed.

## Script Logic

1. **Fetch Latest Release**: Queries the latest tarball version from the GitHub API for GE-Proton.
2. **Version Check**: Confirms whether the latest version is already installed in `$HOME/.steam/root/compatibilitytools.d/`.
3. **Temporary Workspace**: Creates a temporary working directory (`/tmp/proton-ge-custom/`) for downloading files.
4. **Download Process**:
   - Downloads the tarball and its corresponding checksum.
   - Verifies the tarball’s integrity using the checksum before proceeding.
5. **Installation Directory Management**:
   - Creates the required Steam compatibility tools directory (`$HOME/.steam/root/compatibilitytools.d/`) if it doesn’t exist.
   - Extracts the tarball into this directory.
6. **Cleanup**: Deletes the temporary working directory once the installation is complete.

## Key Improvements

- **Version Check:** Prevents redundant downloads and installations by detecting whether the latest release is already installed.
- **Enhanced Usability:** Uses dynamic variables for paths and version names, making the script easier to modify and read.
- **Cleanliness:** Automatically removes the temporary working directory after installation, ensuring no leftover files.

## Usage

Ensure the script is executable:

```bash
chmod +x update-ge-proton.sh
```

Execute the script: 
```bash
./update-ge-proton.sh

```

## Acknowledgments

A special thanks to GloriousEggroll for developing GE-Proton and continuously improving Linux gaming. For more information about the project and its releases, visit the [GE-Proton project on GitHub.](https://github.com/GloriousEggroll/proton-ge-custom).
