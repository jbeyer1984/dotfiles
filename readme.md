this project uses stow to pull dotconfigs

#omg this is so fucking annoying
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/arch_rsa

install zsh
install zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
