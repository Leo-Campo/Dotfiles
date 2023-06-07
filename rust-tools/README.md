# Rust Userland
I stumbled across [this video](https://youtu.be/dFkGNe4oaKk) that showed some nice tools built in Rust.
They do compile practically everywhere and are some of the fastest options in the market,
therefore I decided to give them a try. As more and more rust video will surely 
flood my home (thanks youtube algorithm), I'm sure this list will be updated.

## Installation
The install script here provided will check for rust on your system, install it 
if not present and then install all tools listed here. Aliases and other configurations
may be separated from this, be sure to check the rest of the repo or build your own.

### [sccache](https://github.com/mozilla/sccache)
- Allows for faster cargo compilation time by using cached packages, even in cloud.
- Make sure to have it in your PATH and set up RUSTC_WRAPPER envinronment variable
to use it when compiling, or set the relevant option in your .cargo/config.toml file

### [exa](https://github.com/ogham/exa)
- A replacement for the venerable file listing command ls 

### [Bat](https://github.com/sharkdp/bat)
- A cat clone with wings 

### [zellij](https://github.com/zellij-org/zellij)
- A workspace manager for developers on the terminal

### [ripgrep](https://github.com/behnam/rust-ripgrep)
- A new, faster alternative to grep