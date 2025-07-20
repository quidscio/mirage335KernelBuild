
_check_nv_sequence() {
    _start
    local currentExitStatus
    local functionEntryPWD="$PWD"

    _messagePlain_nominal 'kernel'

    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$2"/linux-* | sort -n | head -n 1)
    _messagePlain_probe_var currentKernelPath

    export currentKernelPath_version=$(echo "$currentKernelPath" | cut -f 2- -d\- | cut -f 1-3 -d. | cut -f 1 -d\- )
    _messagePlain_probe_var currentKernelPath_version

    cd "$currentKernelPath"

    #make olddefconfig
    #make prepare


    _messagePlain_nominal 'wget'

    cd "$safeTmp"
    wget https://raw.githubusercontent.com/soaringDistributions/ubDistBuild/main/_lib/setup/nvidia/_get_nvidia.sh
    ! [[ -e "$safeTmp"/_get_nvidia.sh ]] && _messagePlain_bad 'bad: missing: _get_nvidia.sh' && return 1
    chmod u+x "$safeTmp"/_get_nvidia.sh

    local currentVersion=$("$safeTmp"/_get_nvidia.sh _write_nvidia-"$1")
    _messagePlain_probe_var currentVersion

    ! "$safeTmp"/_get_nvidia.sh _fetch_nvidia-wget "$currentVersion" && return 1
    ! [[ -e "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run ]] && _messagePlain_bad 'bad: missing: NVIDIA-Linux-x86_64-"$currentVersion".run' && return 1


    if "$safeTmp"/_get_nvidia.sh _if_patch_nvidia "$currentVersion" "$currentKernelPath_version"
    then
        ! "$safeTmp"/_get_nvidia.sh _patch_nvidia "$currentVersion" "$currentKernelPath_version" && _messagePlain_bad 'bad: fail: patch' && return 1

        mkdir -p "$safeTmp"/tmp
        #_messagePlain_probe '"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --extract-only'
        #"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --tmpdir="$safeTmp"/tmp --extract-only
        ##mv -f "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"
        #cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom/kernel

        currentExitStatus=0
        ! sudo -n sh "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --tmpdir="$safeTmp"/tmp --ui=none --no-questions -j $(nproc) --no-cc-version-check -k "$currentKernelPath_version" --kernel-source-path "$currentKernelPath" -m=kernel && currentExitStatus=1
        cat /var/log/nvidia-installer.log
        [[ "$currentExitStatus" != "0" ]] && return 1
    else
        mkdir -p "$safeTmp"/tmp
        #_messagePlain_probe '"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --extract-only'
        #"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --tmpdir="$safeTmp"/tmp --extract-only
        #cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

        currentExitStatus=0
        ! sudo -n sh "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --tmpdir="$safeTmp"/tmp --ui=none --no-questions -j $(nproc) --no-cc-version-check -k "$currentKernelPath_version" --kernel-source-path "$currentKernelPath" -m=kernel && currentExitStatus=1
        cat /var/log/nvidia-installer.log
        [[ "$currentExitStatus" != "0" ]] && return 1
    fi

    

    # DISABLED. Has been tested. May eventually be useful toward open-source kernel drivers, or maybe better logging.
    # https://github.com/NVIDIA/open-gpu-kernel-modules
    # Does NOT compile properly with Debian packages splitting the headers with 'common' packages.
    if false
    then
        _messagePlain_nominal 'make'

        export SYSSRC="$currentKernelPath"
        export IGNORE_CC_MISMATCH=1

        export IGNORE_MISSING_MODULE_SYMVERS=1


        cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

        make clean

        _messagePlain_probe 'make -j $(nproc)'
        make -j $(nproc)
        currentExitStatus="$?"
    fi


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
_check_nv-mainline-legacy470() {
    "$scriptAbsoluteLocation" _check_nv_sequence "legacy470" "mainline" "$@"
}
_check_nv-lts-series535p() {
    "$scriptAbsoluteLocation" _check_nv_sequence "series535p" "lts" "$@"
}
_check_nv-lts-legacy470() {
    "$scriptAbsoluteLocation" _check_nv_sequence "legacy470" "lts" "$@"
}






_check_vbox_sequence() {
    local functionEntryPWD="$PWD"
    _start

    local currentExitStatus=0

    _messagePlain_nominal 'kernel'

    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$1"/linux-* | sort -n | head -n 1)
    _messagePlain_probe_var currentKernelPath


    #cd "$currentKernelPath"

    #make olddefconfig
    #make prepare


    _messagePlain_nominal 'dist-get'

    export getMost_backend="direct"
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	_getMost_backend apt-get update

    ! _getMost_ubuntu24-VBoxManage && exit 1



    _messagePlain_nominal 'make'

    if [[ -e /usr/share/virtualbox/src/vboxhost ]]
    then
        cp -r /usr/share/virtualbox/src/vboxhost "$safeTmp"/vboxhost
        cd "$safeTmp"/vboxhost
        make clean
        make -C "$currentKernelPath" M=`pwd` -j $(nproc)
        [[ "$?" != "0" ]] && _messagePlain_bad 'bad: make -C "$currentKernelPath" M=`pwd` -j $(nproc)' && currentExitStatus=1
        #_stop "$?"

        ! [[ -e "$safeTmp"/vboxhost/vboxdrv/vboxdrv.ko ]] && _messagePlain_bad 'bad: missing: vboxdrv.ko' && currentExitStatus=1

        ! [[ -e "$safeTmp"/vboxhost/vboxnetadp/vboxnetadp.ko ]] && _messagePlain_bad 'bad: missing: vboxnetadp.ko' && currentExitStatus=1
        ! [[ -e "$safeTmp"/vboxhost/vboxpci/vboxpci.ko ]] && _messagePlain_bad 'bad: missing: vboxnetadp.ko' && currentExitStatus=1

        [[ "$currentExitStatus" == "0" ]] && _stop 0
    fi



    _messageFAIL
    _stop 1
    return 1
}
_check_vbox-mainline() {
    "$scriptAbsoluteLocation" _check_vbox_sequence "mainline" "$@"
}
_check_vbox-lts() {
    "$scriptAbsoluteLocation" _check_vbox_sequence "lts" "$@"
}



