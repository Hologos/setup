function success() {
    local message="$(echo "${1}" | string_replace --global "${HOME}" "~")"

    printf "\r\033[2K  [  \033[00;32mOK\033[0m  ] %s\n" "${message}"
}

function fail() {
    local message="$(echo "${1}" | string_replace --global "${HOME}" "~")"

    printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] %s\n" "${message}"
}

function info() {
    local message="$(echo "${1}" | string_replace --global "${HOME}" "~")"

    printf "\r  [ \033[00;33mINFO\033[0m ] %s\n" "${message}"
}

function skipped() {
    local message="$(echo "${1}" | string_replace --global "${HOME}" "~")"

    printf "\r  [ \033[00;34mSKIP\033[0m ] %s\n" "${message}"
}

function report_status() {
    local rc_of_last_command="${?}" # ! has to be on the 1st line

    local message_success="${1}"
    local message_failure="${1}"

    if [[ ${#} -eq 2 ]]; then
        message_failure="${2}"
    fi

    if [[ ${rc_of_last_command} -eq 0 ]]; then
        success "${message_success}"
    else
        fail "${message_failure}"
    fi
}

function string_replace() {
    local search=""
    local replace=""
    local subject=""
    local global=""

    local search_found=0
    local replace_found=0

    while [[ ${#} -ne 0 ]] && [[ "${1}" != "" ]]; do
        case ${1} in
            --global)
                global="g"
            ;;

            *)
                if [[ ${search_found} -eq 0 ]]; then
                    search="${1}"
                    search_found=1
                elif [[ ${replace_found} -eq 0 ]]; then
                    replace="${1}"
                    replace_found=1
                else
                    >&2 echo "Unknown input argument."
                    return 1
                fi
            ;;
        esac

        shift
    done

    read subject < /dev/stdin

    local search_quoted="$(printf '%s' "${search}" | sed 's/[#\]/\\\0/g')"
    local replace_quoted="$(printf '%s' "${replace}" | sed 's/[#\]/\\\0/g')"
    local subject_quoted="$(printf '%s' "${subject}" | sed 's/[#\]/\\\0/g')"

    if [[ "${search_quoted}" == "" ]]; then
        >&2 echo "Search cannot be empty."
        return 1
    elif [[ "${replace_quoted}" == "" ]]; then
        >&2 echo "Replace cannot be empty."
        return 1
    elif [[ "${subject_quoted}" == "" ]]; then
        >&2 echo "Subject cannot be empty."
        return 1
    fi

    echo "${subject_quoted}" | sed "s#${search_quoted}#${replace_quoted}#${global}"
}

function link_file() {
    local source="${1}"
    local target="${2}"

    if [[ -L "${target}" ]]; then
        if [[ "$(readlink "${target}")" == "${source}" ]]; then
            skipped "symlink ${source} to ${target} already exists"
            return 0
        else
            fail "symlink ${target} exists but points to ${source}"
            return 1
        fi
    fi

    if [[ -e "${target}" ]] && [[ ! -L "${target}" ]]; then
        fail "${target} already exists but is not a symlink"
        return 0
    else
        echo "DEBUG:"

        echo -n " "
        ls -ld "${target}"

        echo " target=${target}"

        if [[ -f "${target}" ]]; then
            echo " file exists=true"
        else
            echo " file exists=false"
        fi

        if [[ -L "${target}" ]]; then
            echo " symlink exists=true"
        else
            echo " syml exists=false"
        fi
    fi

    ln -nfs "${source}" "${target}"
    report_status "linking ${source} to ${target}"
}

function is_installed() {
    which "${1}" &> /dev/null && return 0

    return 1
}

function create_directory() {
    local dirpath="${1}"

    if [[ -d "${dirpath}" ]]; then
        skipped "directory ${dirpath} already exists"
        return 0
    fi

    command mkdir -p "${dirpath}"

    report_status "creating directory ${dirpath}"
}
