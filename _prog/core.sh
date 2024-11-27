##### Core


_test_build_kernel() {
	_getDep wget
	_getDep axel
	
	_getDep gcc
	_getDep g++
	_getDep make
	
	_getDep ld
	
	_getDep patch
	
	_getDep gpg
	
	_getDep tar
	_getDep xz
	_getDep gzip
	_getDep bzip2
	
	_getDep pahole
	
	_getDep lz4
	_getDep lz4c
	
	_getDep bison
	_getDep flex
	
	_getDep libelf.so
	_getDep gelf.h
	_getDep eu-strip
	
	_getDep rsync
	
	_test_kernelConfig
}




_fetchKernel-lts-legacyHTTPS() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/lts/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/lts
	
	mkdir -p "$scriptLocal"/lts
	cd "$scriptLocal"/lts
	
	#currentKernelURL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.61.tar.xz"
	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep '6\.1\.' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/lts/"$currentKernelName"
	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		wget "$currentKernelURL"
		tar xf "$currentKernelName"*
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/lts/
	cp "$scriptLib"/linux/lts/.config "$scriptLocal"/lts/"$currentKernelName"/
}

_fetchKernel-mainline-legacyHTTPS() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/mainline/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/mainline
	
	mkdir -p "$scriptLocal"/mainline
	cd "$scriptLocal"/mainline
	
	#currentKernelURL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.61.tar.xz"
	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/mainline/"$currentKernelName"
	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		wget "$currentKernelURL"
		tar xf "$currentKernelName"*
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/mainline/
	cp "$scriptLib"/linux/mainline/.config "$scriptLocal"/mainline/"$currentKernelName"/
}






_fetchKernel-lts() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	! [[ "$current_keepFetch" == "true" ]] && _safeRMR "$scriptLocal"/lts"$currentKernelPlatform"

	mkdir -p "$scriptLocal"/lts"$currentKernelPlatform"
	cd "$scriptLocal"/lts"$currentKernelPlatform"


	if [[ "$forceKernel_lts" == "" ]]
	then
		# ATTENTION: Omit the trailing '.' if patchlevel is "" . Usually though, for a preferable well established LTS kernel, the patchlevel will not be empty.
		# WARNING: May not be tested with an empty patchlevel.
		#export currentKernel_MajorMinor='5.10.'
		#export currentKernel_MajorMinor='6.1.'
		#export currentKernel_MajorMinor='6.6.'
		export currentKernel_MajorMinor_regex="linux-"$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

		# WARNING: Sorting the git tags has the benefit of depending on one rather than two upstream sources, at the risk that the git tags may not be as carefully curated. Not recommended as default.
		#git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
		#cd "$scriptLocal"/lts"$currentKernelPlatform"/linux
		#export currentKernel_patchLevel=$(git tag | grep '^v'"$currentKernel_MajorMinor_regex" | sed 's/v'"$currentKernel_MajorMinor_regex"'//g' | tr -dc '0-9\.\n' | sort -n | tail -n1)
		#export currentKernelName=linux-"$currentKernel_MajorMinor""$currentKernel_patchLevel"
		#cd "$scriptLocal"/lts"$currentKernelPlatform"


		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep "$currentKernel_MajorMinor_regex" | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

		export currentKernel_version="$currentKernel_MajorMinor""$currentKernel_patchLevel"
	else
		export forceKernel_lts_regex=$(echo "$forceKernel_lts" | sed 's/\./\\./g')

		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep "$forceKernel_lts_regex" | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_version=$(echo "$currentKernelName" | tr -dc '0-9\.\n')
	fi


	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	_messagePlain_probe_var currentKernel_MajorMinor

	_messagePlain_probe_var currentKernel_version

	_messagePlain_probe v"$currentKernel_MajorMinor""$currentKernel_patchLevel"

	
	cd "$scriptLocal"/lts"$currentKernelPlatform"

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1
		git config --global fetch.parallel 10

		if ! [[ -e "$scriptLocal"/lts"$currentKernelPlatform"/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			#! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_version" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/lts"$currentKernelPlatform"/linux
		#! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1
		! git checkout v"$currentKernel_version" && _messageError 'fail: git: checkout: 'v"$currentKernel_version" && _messageFAIL && _stop 1



		cd "$scriptLocal"/lts"$currentKernelPlatform"

		mv "$scriptLocal"/lts"$currentKernelPlatform"/linux "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		mv "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/.git "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".git
		( [[ "$skimfast" == "true" ]] || [[ $current_force_bindepOnly == "true" ]] ) && [[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-0 -T0"
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		[[ $current_force_bindepOnly != "true" ]] && env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".tar.xz ./"$currentKernelName"
		#[[ "$current_force_bindepOnly" =="true" ]] && export current_force_bindepOnly=false
		mv "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".git "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/lts"$currentKernelPlatform"/
	cp -f "$scriptLib"/linux/lts"$currentKernelPlatform"/.config "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/

}
_fetchKernel-lts-server() {
	export currentKernelPlatform="-server"
	_fetchKernel-lts "$@"
	export currentKernelPlatform=""
}


_fetchKernel-mainline() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/mainline"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	! [[ "$current_keepFetch" == "true" ]] && _safeRMR "$scriptLocal"/mainline"$currentKernelPlatform"

	mkdir -p "$scriptLocal"/mainline"$currentKernelPlatform"
	cd "$scriptLocal"/mainline"$currentKernelPlatform"

	if [[ "$forceKernel_mainline" == "" ]]
	then
		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_Major=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 1 -d '.')
		export currentKernel_Minor=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 2 -d '.')
		export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

		export currentKernel_MajorMinor="$currentKernel_Major"
		[[ "$currentKernel_Minor" != "" ]] && export currentKernel_MajorMinor="$currentKernel_Major"".""$currentKernel_Minor"
		[[ "$currentKernel_patchLevel" != "" ]] && export currentKernel_MajorMinor="$currentKernel_MajorMinor""."
		export currentKernel_MajorMinor_regex="linux-"$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

		export currentKernel_version="$currentKernel_MajorMinor""$currentKernel_patchLevel"	
	else
		export forceKernel_mainline_regex=$(echo "$forceKernel_mainline" | sed 's/\./\\./g')

		# WARNING: Sorting the git tags has the benefit of depending on one rather than two upstream sources, at the risk that the git tags may not be as carefully curated. Not recommended as default.
		# Specific, not latest, versions are expected always available from git tags . Robust for that usage.
		git config --global checkout.workers -1
		git config --global fetch.parallel 10
		export currentKernel_version=$(git ls-remote --tags git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git | sed 's/^.*refs\/tags\///g' | grep '^v'"$forceKernel_mainline_regex" | sed 's/^v//g' | sed 's/\^{}//g' | sort -V | tail -n1)
		export currentKernelName=linux-"$currentKernel_version"
		export currentKernelPath="$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"
	fi

	

	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	_messagePlain_probe_var currentKernel_MajorMinor

	_messagePlain_probe_var currentKernel_version
	
	cd "$scriptLocal"/mainline"$currentKernelPlatform"

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1
		git config --global fetch.parallel 10

		if ! [[ -e "$scriptLocal"/mainline"$currentKernelPlatform"/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			#! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_version" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/mainline"$currentKernelPlatform"/linux
		#! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1
		! git checkout v"$currentKernel_version" && _messageError 'fail: git: checkout: 'v"$currentKernel_version" && _messageFAIL && _stop 1



		cd "$scriptLocal"/mainline"$currentKernelPlatform"

		mv "$scriptLocal"/mainline"$currentKernelPlatform"/linux "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"

		mv "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/.git "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".git
		( [[ "$skimfast" == "true" ]] || [[ $current_force_bindepOnly == "true" ]] ) && [[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-0 -T0"
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		[[ $current_force_bindepOnly != "true" ]] && env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".tar.xz ./"$currentKernelName"
		#[[ "$current_force_bindepOnly" =="true" ]] && export current_force_bindepOnly=false
		mv "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".git "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/mainline"$currentKernelPlatform"/
	cp -f "$scriptLib"/linux/mainline"$currentKernelPlatform"/.config "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/

}
_fetchKernel-mainline-server() {
	export currentKernelPlatform="-server"
	_fetchKernel-mainline "$@"
	export currentKernelPlatform=""
}



_test_fetchKernel_updateInterval-setupUbiquitous() {
	! find "$scriptLocal"/.retest-setupUbiquitous"$1" -type f -mtime -9 2>/dev/null | grep '.retest-setupUbiquitous' > /dev/null 2>&1
	
	#return 0
	return
}


_fetchKernel() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	if _test_fetchKernel_updateInterval-setupUbiquitous
	then
		rm -f "$scriptLocal"/.retest-setupUbiquitous > /dev/null 2>&1
		touch "$scriptLocal"/.retest-setupUbiquitous
		date +%s > "$scriptLocal"/.retest-setupUbiquitous
		"$scriptAbsoluteLocation" _setupUbiquitous
		[[ ! -e "$HOME"/.ubcore/ubiquitous_bash/.git ]] && "$scriptAbsoluteLocation" _setupUbiquitous_nonet
	fi
	
	_test_build_kernel "$@"
	
	
	
	_fetchKernel-lts "$@"
	
	
	_fetchKernel-mainline "$@"
	
	
	
	
	
	
	cd "$functionEntryPWD"
	_stop
}


# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
_kernelScripts-disableDebug() {
	#scripts/config --disable DEBUG_INFO

	scripts/config --disable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
	
	scripts/config --undefine GDB_SCRIPTS
	scripts/config --undefine DEBUG_INFO
	scripts/config --undefine DEBUG_INFO_SPLIT
	scripts/config --undefine DEBUG_INFO_REDUCED
	scripts/config --undefine DEBUG_INFO_COMPRESSED
	scripts/config --set-val  DEBUG_INFO_NONE       y
	scripts/config --set-val  DEBUG_INFO_DWARF5     n
}


_rmCerts-kernel() {
	rm -f ./certs/.*cmd ./certs/.*d ./certs/*.cmd ./certs/*.d ./certs/*.o ./certs/*.a ./certs/*.order ./certs/*.pem ./certs/blacklist_hash_list ./certs/extract-cert ./certs/x509_certificate_list ./certs/x509_revocation_list ./certs/extra_certificates ./certs/*.priv ./certs/signing_key* ./certs/x509.genkey ./certs/*.a ./certs/*.elf ./certs/*.mod ./certs/*.mod.* ./certs/*.o.* ./certs/*.s ./certs/*.so ./certs/*.so.* ./certs/*.symvers
}

_buildKernel-lts() {
	_messageNormal "init: buildKernel-lts: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}
_buildKernel-lts-server() {
	_messageNormal "init: buildKernel-lts-server: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_server ./.config | tee "$scriptLocal"/lts-server/statement.sh.out.txt
	cp "$scriptLocal"/lts-server/*/.config "$scriptLocal"/lts-server/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}

_buildKernel-mainline() {
	_messageNormal "init: buildKernel-mainline: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/mainline/statement.sh.out.txt
	cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/mainline/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}
_buildKernel-mainline-server() {
	_messageNormal "init: buildKernel-mainline-server: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_server ./.config | tee "$scriptLocal"/mainline-server/statement.sh.out.txt
	cp "$scriptLocal"/mainline-server/*/.config "$scriptLocal"/mainline-server/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}




_menuconfigKernel-lts() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/lts/linux-* | sort -V | head -n 1)
	cd "$currentKernelPath"

	_messageNormal "init: menuconfigKernel-lts: ""$currentKernelPath"
	make olddefconfig

	make menuconfig

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	return 0
}

_menuconfigKernel-mainline() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/mainline/linux-* | sort -V | head -n 1)
	cd "$currentKernelPath"

	_messageNormal "init: menuconfigKernel-mainline: ""$currentKernelPath"
	make olddefconfig

	make menuconfig
	
	_kernelConfig_desktop ./.config | tee "$scriptLocal"/mainline/statement.sh.out.txt
	cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/mainline/
	
	return 0
}



_build_cloud_prepare() {
	if _test_fetchKernel_updateInterval-setupUbiquitous
	then
		rm -f "$scriptLocal"/.retest-setupUbiquitous > /dev/null 2>&1
		touch "$scriptLocal"/.retest-setupUbiquitous
		date +%s > "$scriptLocal"/.retest-setupUbiquitous
		"$scriptAbsoluteLocation" _setupUbiquitous
		[[ ! -e "$HOME"/.ubcore/ubiquitous_bash/.git ]] && "$scriptAbsoluteLocation" _setupUbiquitous_nonet
	fi
	
	_test_build_kernel "$@"
}




_build_cloud_lts() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-lts "$@"
	_buildKernel-lts "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud_mainline() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-mainline "$@"
	_buildKernel-mainline "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud_mainline-server() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-mainline-server "$@"
	_buildKernel-mainline-server "$@"
	
	cd "$functionEntryPWD"
}
_build_cloud_lts-server() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-lts-server "$@"
	_buildKernel-lts-server "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_prepare "$@"
	
	_build_cloud_lts "$@"
	
	_build_cloud_mainline "$@"
	
	cd "$functionEntryPWD"
	_stop
}






_export_cloud_prepare() {
	_messagePlain_nominal "init: _export_cloud_prepare"
	
	mkdir -p "$scriptLocal"/_export
	mkdir -p "$scriptLocal"/_tmp
}

_export_cloud_lts() {
	_export_cloud_prepare
	cd "$scriptLocal"/_tmp
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	if ls -1 "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: lts"$currentKernelPlatform"'
		
		mkdir -p "$scriptLocal"/_tmp/lts"$currentKernelPlatform"
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/lts"$currentKernelPlatform"/* "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/lts"$currentKernelPlatform"/* "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/.
		rm -f "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/lts"$currentKernelPlatform"/*/.config "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/
		
		
		_messagePlain_nominal '_export_cloud: lts"$currentKernelPlatform": debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-lts"$currentKernelPlatform"-amd64-debian.tar.gz ./lts"$currentKernelPlatform"/
		mv linux-lts"$currentKernelPlatform"-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: lts"$currentKernelPlatform": all'
		#cd "$scriptLocal"
		#tar -czf linux-lts"$currentKernelPlatform"-amd64-all.tar.gz ./lts"$currentKernelPlatform"/
		##env XZ_OPT=-e9 tar -cJf linux-lts"$currentKernelPlatform"-amd64-all.tar.xz ./lts"$currentKernelPlatform"/
		##env XZ_OPT=-5 tar -cJf linux-lts"$currentKernelPlatform"-amd64-all.tar.xz ./lts"$currentKernelPlatform"/
		#mv linux-lts"$currentKernelPlatform"-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/lts"$currentKernelPlatform"
		
		du -sh "$scriptLocal"/_export/linux-lts"$currentKernelPlatform"*
	else
		_messageError 'bad: missing: "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz' && _messageFAIL && _stop 1
	fi
}
_export_cloud_lts-server() {
	export currentKernelPlatform="-server"
	_export_cloud_lts "$@"
	export currentKernelPlatform=""
}

_export_cloud_mainline() {
	_export_cloud_prepare
	cd "$scriptLocal"/_tmp
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	if ls -1 "$scriptLocal"/mainline"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: mainline"$currentKernelPlatform"'
		
		mkdir -p "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/mainline"$currentKernelPlatform"/* "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/mainline"$currentKernelPlatform"/* "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/.
		rm -f "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/mainline"$currentKernelPlatform"/*/.config "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/
		
		
		_messagePlain_nominal '_export_cloud: mainline"$currentKernelPlatform": debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-mainline"$currentKernelPlatform"-amd64-debian.tar.gz ./mainline"$currentKernelPlatform"/
		mv linux-mainline"$currentKernelPlatform"-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: mainline"$currentKernelPlatform": all'
		#cd "$scriptLocal"
		#tar -czf linux-mainline"$currentKernelPlatform"-amd64-all.tar.gz ./mainline"$currentKernelPlatform"/
		##env XZ_OPT=-e9 tar -cJf linux-mainline"$currentKernelPlatform"-amd64-all.tar.xz ./mainline"$currentKernelPlatform"/
		##env XZ_OPT=-5 tar -cJf linux-mainline"$currentKernelPlatform"-amd64-all.tar.xz ./mainline"$currentKernelPlatform"/
		#mv linux-mainline"$currentKernelPlatform"-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"
		
		du -sh "$scriptLocal"/_export/linux-mainline"$currentKernelPlatform"*
	fi
}
_export_cloud_mainline-server() {
	export currentKernelPlatform="-server"
	_export_cloud_mainline "$@"
	export currentKernelPlatform=""
}



_export_cloud() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_messageNormal "init: _export_cloud"
	
	_export_cloud_lts
	
	_export_cloud_mainline
	
	echo "_"
	du -sh "$scriptLocal"/_export/*
	
	cd "$functionEntryPWD"
	_stop
}




# ATTENTION: Override with 'ops.sh' or similar!
_upload_cloud_lts() {
	_rclone_limited --progress copy "$scriptLocal"/_export/linux-lts-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}

# ATTENTION: Override with 'ops.sh' or similar!
_upload_cloud_mainline() {
	_rclone_limited --progress copy "$scriptLocal"/_export/linux-mainline-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}

_upload_cloud() {
	_upload_cloud_lts
	_upload_cloud_mainline
}


_create_lts() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_lts
	
	_export_cloud_lts
	
	_upload_cloud_lts
	
	cd "$functionEntryPWD"
	_stop
}

_create_mainline() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_mainline
	
	_export_cloud_mainline
	
	_upload_cloud_mainline
	
	cd "$functionEntryPWD"
	_stop
}





_refresh_anchors() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_prepare
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud_mainline
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_mainline
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_getMinimal_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_fetchKernel


	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_menuconfigKernel-lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_menuconfigKernel-mainline
}



