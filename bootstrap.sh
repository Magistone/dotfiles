for package in $(cat pkglist); do
	sudo apt install $package
done

#nvim install
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc

#rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#golang
curl https://go.dev/dl/go1.24.3.linux-amd64.tar.gz
 rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

#nvm + node (& npm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

nvm install --lts


./install.sh
