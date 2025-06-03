directories=nvim

for dir in $directories; do
	cp -rf $dir ~/.config/$dir
done

inflatable=tmux
for dir in $inflatable; do
	cp -r $dir/. ~/
done

mkdir ~/.local/bin
cp -r scripts/. ~/.local/bin/
