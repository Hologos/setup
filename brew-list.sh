if ! is_installed "brew"; then
    # download & install brew
    report status "installing brew"
else
    skipped "installing brew"
fi

items_to_install="
bash
coreutils
dnsmasq
git
gnupg
mas
openssh
openssl
pandoc
pass
peru
pinentry-mac
python
reattach-to-user-namespace
sqlite
tmux
tree
wget
zsh
"

for item_to_install in ${items_to_install} ; do
    brew install "${item_to_install}"
    report_status "installing ${item_to_install}"
done
