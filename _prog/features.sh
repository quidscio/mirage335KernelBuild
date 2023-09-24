
_check_nv_sequence() {
    _start
    local currentExitStatus
    local functionEntryPWD="$PWD"


    cd "$safeTmp"
    wget https://raw.githubusercontent.com/soaringDistributions/ubDistBuild/main/_lib/setup/nvidia/_get_nvidia.sh
    ! [[ -e "$safeTmp"/_get_nvidia.sh ]] && _messagePlain_bad 'bad: missing: _get_nvidia.sh' && return 1
    chmod u+x "$safeTmp"/_get_nvidia.sh

    local currentVersion=$("$safeTmp"/_get_nvidia.sh _write_nvidia-"$1")
    _messagePlain_probe_var currentVersion

    ! "$safeTmp"/_get_nvidia.sh _fetch_nvidia-wget "$currentVersion" && return 1
    ! [[ -e "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run ]] && _messagePlain_bad 'bad: missing: NVIDIA-Linux-x86_64-"$currentVersion".run' && return 1
	return 0


    "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --extract-only
    cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel



    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$2"/linux-* | sort -n | head -n 1)

    export SYSSRC="$currentKernelPath"
    export IGNORE_CC_MISMATCH=1

    _messagePlain_probe_var currentKernelPath


    cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

    make clean

    make -j $(nproc)
    currentExitStatus="$?"

    

    cd "$localFunctionEntryPWD"
    if [[ "$currentExitStatus" != "0" ]]
    then
        _messageFAIL
        _stop 1
        return 1
    fi
    _stop "$currentExitStatus"
}
_check_nv-mainline-series535p() {
    "$scriptAbsoluteLocation" _check_nv_sequence "series535p" "mainline" "$@"
}

#legacy470

#lts

