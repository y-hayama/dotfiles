#/bin/bash -eux
# for M1 Mac

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew shellenv
brew install anyenv gradle

# anyenv
anyenv init -
echo 'eval "$(anyenv init -)"' >> ~/.zshrc
exec $SHELL -l
anyenv -v
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
anyenv update
anyenv install nodenv jenv
jenv enable-plugin export
exec $SHELL -l

# docker
curl -O https://desktop.docker.com/mac/main/arm64/Docker.dmg ~/Desktop/Docker.dmg

# gcloud
brew install --cask google-cloud-sdk

# aws
brew install awscli
aws --version

# kubernetes
brew install kubectx
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | shasum -a 256 --check
if($? -neq 0) exit 1
rm -f kubectl.sha256
chmod +x ./kubectl
sudo mkdir -p /usr/local/bin
sudo mv ./kubectl /usr/local/bin/kubectl
