# items_to_install="
# ${HOME}/Softwares/bin
# ${HOME}/Softwares/Library
# ${HOME}/Sync/KB
# ${HOME}/Sync/Projects
# ${HOME}/Sync/Scripts
# ${HOME}/Sync/Work
# ${HOME}/.config
# ${HOME}/.ssh
# ${HOME}/.smime
# ${HOME}/bin
# ${HOME}/Screenshots
# "

# items_to_install="
# test1 test2
# test3 test4
# "

# for item_to_install in ${items_to_install} ; do
#     # create_symlink "${item_to_install}"
#     echo "${item_to_install}"
# done



link_file "${HOME}/Documents" "${HOME}/Sync/Documents"
link_file "${HOME}/Sync/KB" "${HOME}/KB"
link_file "${HOME}/Sync/Projects" "${HOME}/Software/Projects"
link_file "${HOME}/Sync/Scripts" "${HOME}/Software/Scripts"
link_file "${HOME}/Sync/Work" "${HOME}/Work"
link_file "/tmp" "${HOME}/tmp"
