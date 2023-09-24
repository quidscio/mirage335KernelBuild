
_check_nv_sequence() {
    _start
    local currentExitStatus
    local functionEntryPWD="$PWD"

    _messagePlain_nominal 'kernel'

    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$2"/linux-* | sort -n | head -n 1)
    _messagePlain_probe_var currentKernelPath

    cd "$currentKernelPath"

    make olddefconfig
    make prepare


    _messagePlain_nominal 'wget'

    cd "$safeTmp"
    wget https://raw.githubusercontent.com/soaringDistributions/ubDistBuild/main/_lib/setup/nvidia/_get_nvidia.sh
    ! [[ -e "$safeTmp"/_get_nvidia.sh ]] && _messagePlain_bad 'bad: missing: _get_nvidia.sh' && return 1
    chmod u+x "$safeTmp"/_get_nvidia.sh

    local currentVersion=$("$safeTmp"/_get_nvidia.sh _write_nvidia-"$1")
    _messagePlain_probe_var currentVersion

    ! "$safeTmp"/_get_nvidia.sh _fetch_nvidia-wget "$currentVersion" && return 1
    ! [[ -e "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run ]] && _messagePlain_bad 'bad: missing: NVIDIA-Linux-x86_64-"$currentVersion".run' && return 1


    _messagePlain_probe '"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --extract-only'
    "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --extract-only
    cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel



    _messagePlain_nominal 'make'

    export SYSSRC="$currentKernelPath"
    export IGNORE_CC_MISMATCH=1
    
    export IGNORE_MISSING_MODULE_SYMVERS=1

    
    cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

    make clean

    _messagePlain_probe 'make -j $(nproc)'
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






_check_vbox-mainline() {
    export getMost_backend="direct"
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	_getMost_backend apt-get update
    
    ! _getMost_ubuntu22-VBoxManage && exit 1



    _messageFAIL
    _stop 1
    return 1
}




