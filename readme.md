this project uses stow to pull dotconfigs

#omg this is so fucking annoying
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/arch_rsa

#put it in .ssh
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/your_private_key

install nala
install zsh
install xclip
install zeoxide
install zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1

install eza
install bat
~/.local/bin\
ln -s /usr/bin/batcat ~/.local/bin/bat

install fd-find
ln -s $(which fdfind) ~/.local/bin/fd

install stow
install kitty
install rofi

install doublecmd-gtk





