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
	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep '5\.10' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
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
	rm -f "$scriptLocal"/lts/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/lts

	mkdir -p "$scriptLocal"/lts
	cd "$scriptLocal"/lts


	# ATTENTION: Omit the trailing '.' if patchlevel is "" . Usually though, for a preferable well established LTS kernel, the patchlevel will not be empty.
	# WARNING: May not be tested with an empty patchlevel.
	#export currentKernel_MajorMinor='5.10.'
	export currentKernel_MajorMinor='6.1.'
	export currentKernel_MajorMinor_regex=$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

	# WARNING: Sorting the git tags has the benefit of depending on one rather than two upstream sources, at the risk that the git tags may not be as carefully curated. Not recommended as default.
	#git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
	#cd "$scriptLocal"/lts/linux
	#export currentKernel_patchLevel=$(git tag | grep '^v'"$currentKernel_MajorMinor_regex" | sed 's/v'"$currentKernel_MajorMinor_regex"'//g' | tr -dc '0-9\.\n' | sort -n | tail -n1)
	#export currentKernelName=linux-"$currentKernel_MajorMinor""$currentKernel_patchLevel"
	#cd "$scriptLocal"/lts


	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep "$currentKernel_MajorMinor_regex" | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/lts/"$currentKernelName"

	export export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	
	cd "$scriptLocal"/lts

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1

		if ! [[ -e "$scriptLocal"/lts/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/lts/linux
		! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1



		cd "$scriptLocal"/lts

		mv "$scriptLocal"/lts/linux "$scriptLocal"/lts/"$currentKernelName"

		mv "$scriptLocal"/lts/"$currentKernelName"/.git "$scriptLocal"/lts/"$currentKernelName".git
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/lts/"$currentKernelName".tar.xz ./"$currentKernelName"
		mv "$scriptLocal"/lts/"$currentKernelName".git "$scriptLocal"/lts/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/lts/
	cp "$scriptLib"/linux/lts/.config "$scriptLocal"/lts/"$currentKernelName"/

}


_fetchKernel-mainline() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/mainline/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/mainline

	mkdir -p "$scriptLocal"/mainline
	cd "$scriptLocal"/mainline


	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/mainline/"$currentKernelName"

	export currentKernel_Major=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 1 -d '.')
	export currentKernel_Minor=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 2 -d '.')
	export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

	export currentKernel_MajorMinor="$currentKernel_Major"
	[[ "$currentKernel_Minor" != "" ]] && export currentKernel_MajorMinor="$currentKernel_Major"".""$currentKernel_Minor"
	[[ "$currentKernel_patchLevel" != "" ]] && export currentKernel_MajorMinor="$currentKernel_MajorMinor""."
	export currentKernel_MajorMinor_regex=$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	_messagePlain_probe_var currentKernel_MajorMinor

	_messagePlain_probe v"$currentKernel_MajorMinor""$currentKernel_patchLevel"
	
	cd "$scriptLocal"/mainline

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1

		if ! [[ -e "$scriptLocal"/mainline/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/mainline/linux
		! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1



		cd "$scriptLocal"/mainline

		mv "$scriptLocal"/mainline/linux "$scriptLocal"/mainline/"$currentKernelName"

		mv "$scriptLocal"/mainline/"$currentKernelName"/.git "$scriptLocal"/mainline/"$currentKernelName".git
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/mainline/"$currentKernelName".tar.xz ./"$currentKernelName"
		mv "$scriptLocal"/mainline/"$currentKernelName".git "$scriptLocal"/mainline/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/mainline/
	cp "$scriptLib"/linux/mainline/.config "$scriptLocal"/mainline/"$currentKernelName"/

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


_buildKernel-lts() {
	_messageNormal "init: buildKernel-lts: ""$currentKernelPath"
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
	
	make deb-pkg -j $(nproc)
	[[ "$?" != "0" ]] && _messageFAIL
	
	return 0
}

_buildKernel-mainline() {
	_messageNormal "init: buildKernel-mainline: ""$currentKernelPath"
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
	
	make deb-pkg -j $(nproc)
	[[ "$?" != "0" ]] && _messageFAIL
	
	return 0
}




_menuconfigKernel-lts() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/lts/linux-* | sort -n | head -n 1)
	cd "$currentKernelPath"

	_messageNormal "init: menuconfigKernel-lts: ""$currentKernelPath"
	make olddefconfig

	make menuconfig

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	return 0
}

_menuconfigKernel-mainline() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/mainline/linux-* | sort -n | head -n 1)
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
	if ls -1 "$scriptLocal"/lts/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: lts'
		
		mkdir -p "$scriptLocal"/_tmp/lts
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/lts/* "$scriptLocal"/_tmp/lts/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/lts/* "$scriptLocal"/_tmp/lts/.
		rm -f "$scriptLocal"/_tmp/lts/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/lts/*/.config "$scriptLocal"/_tmp/lts/
		
		
		_messagePlain_nominal '_export_cloud: lts: debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-lts-amd64-debian.tar.gz ./lts/
		mv linux-lts-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: lts: all'
		#cd "$scriptLocal"
		#tar -czf linux-lts-amd64-all.tar.gz ./lts/
		##env XZ_OPT=-e9 tar -cJf linux-lts-amd64-all.tar.xz ./lts/
		##env XZ_OPT=-5 tar -cJf linux-lts-amd64-all.tar.xz ./lts/
		#mv linux-lts-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/lts
		
		du -sh "$scriptLocal"/_export/linux-lts*
	else
		_messageError 'bad: missing: "$scriptLocal"/lts/*.tar.xz' && _messageFAIL && _stop 1
	fi
}

_export_cloud_mainline() {
	_export_cloud_prepare
	cd "$scriptLocal"/_tmp
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	if ls -1 "$scriptLocal"/mainline/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: mainline'
		
		mkdir -p "$scriptLocal"/_tmp/mainline
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/mainline/* "$scriptLocal"/_tmp/mainline/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/mainline/* "$scriptLocal"/_tmp/mainline/.
		rm -f "$scriptLocal"/_tmp/mainline/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/_tmp/mainline/
		
		
		_messagePlain_nominal '_export_cloud: mainline: debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-mainline-amd64-debian.tar.gz ./mainline/
		mv linux-mainline-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: mainline: all'
		#cd "$scriptLocal"
		#tar -czf linux-mainline-amd64-all.tar.gz ./mainline/
		##env XZ_OPT=-e9 tar -cJf linux-mainline-amd64-all.tar.xz ./mainline/
		##env XZ_OPT=-5 tar -cJf linux-mainline-amd64-all.tar.xz ./mainline/
		#mv linux-mainline-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/mainline
		
		du -sh "$scriptLocal"/_export/linux-mainline*
	fi
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



