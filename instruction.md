# Link config

```
ln -s ~/devconf/.zshrc ~/
ln -s ~/devconf/.tmux.conf ~/
ln -s ~/devconf/.gitconfig ~/
ln -s ~/devconf/.p10k.zsh ~/
ln -s ~/devconf/.config/aquaproj-aqua ~/.config/
ln -s ~/devconf/.config/lsd ~/.config/
ln -s ~/devconf/.config/sheldon ~/.config/
```

# Tmux

## tpm

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# Install Rust (rustup)

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

# Install aqua

```shell
brew install aquaproj/aqua/aqua
# or
go install github.com/aquaproj/aqua/v2/cmd/aqua@latest
```

## Install

```
aqua i -a
```
