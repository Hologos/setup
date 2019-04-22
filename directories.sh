items_to_install="
${HOME}/Software/bin
${HOME}/Software/Library
${HOME}/Sync/KB
${HOME}/Sync/Projects
${HOME}/Sync/Scripts
${HOME}/Sync/Work
${HOME}/.config
${HOME}/.ssh
${HOME}/.smime
${HOME}/bin
${HOME}/Screenshots
"

for item_to_install in ${items_to_install} ; do
    create_directory "${item_to_install}"
done
