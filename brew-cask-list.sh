if ! is_installed "brew"; then
    # download & install brew
    report status "installing brew"
else
    skipped "installing brew"
fi

items_to_install="
1password
caprine
discord
dropbox
karabiner-elements
resilio-sync
skype-for-business
teamviewer
telegram
toggl
tripmode
typora
visual-studio-code
vlc
"

for item_to_install in ${items_to_install} ; do
    brew cask install "${item_to_install}"
done
