# Configuration Setup

This repository contains configuration files and setup scripts for various applications and tools.

## Nerd Fonts Installation

To install Nerd Fonts:

1. Create a directory named `patched-fonts` in your home directory:

    ```bash
    mkdir -p ~/patched-fonts
    ```

2. Save your desired Nerd Font files into the `~/patched-fonts/` directory.

3. Run the installation script:

    ```bash
    ./nerd.sh
    ```
## Neovim Setup

This setup is intended for **Ubuntu** users. It installs Neovim, its dependencies, and applies a custom `init.lua` configuration.

### Installation Instructions

1. Open your terminal, cd into nvim and run the script:

    ```bash
    cd nvim
    ./install.sh
    ```

    > ⚠️ **Do not run the script with `sudo`.**  
    > The script will prompt you for your password when elevated permissions are needed.

2. After installation, launch Neovim with:

    ```bash
    vi
    ```
