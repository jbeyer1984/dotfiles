this project uses stow to pull dotconfigs

#omg this is so fucking annoying
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/arch_rsa

#put it in .ssh
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/your_private_key

install zsh
install zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
