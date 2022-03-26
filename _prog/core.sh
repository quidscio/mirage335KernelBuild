##### Core



# Unusual. Strongly discouraged. Building Linux Kernel with fewer resources is helpful for compatibility and performance with some constrained and repetitive cloud services.
_getMinimal_cloud() {
	"$scriptAbsoluteLocation" _setupUbiquitous
	
	
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	_set_getMost_backend "$@"
	_test_getMost_backend "$@"
	#_getMost_debian11_aptSources "$@"
	
	
	
	_getMost_backend apt-get update
	_getMost_backend_aptGetInstall sudo
	_getMost_backend_aptGetInstall gpg
	_getMost_backend_aptGetInstall --reinstall wget
	
	_getMost_backend_aptGetInstall vim
	
	_getMost_backend_aptGetInstall linux-image-amd64
	
	_getMost_backend_aptGetInstall pigz
	
	_getMost_backend_aptGetInstall qalc
	
	_getMost_backend_aptGetInstall octave
	
	_getMost_backend_aptGetInstall curl
	_getMost_backend_aptGetInstall gdisk
	_getMost_backend_aptGetInstall lz4
	_getMost_backend_aptGetInstall mawk
	_getMost_backend_aptGetInstall nano
	
	_getMost_backend_aptGetInstall build-essential
	_getMost_backend_aptGetInstall bison
	_getMost_backend_aptGetInstall libelf-dev
	_getMost_backend_aptGetInstall elfutils
	
	_getMost_backend_aptGetInstall patch
	
	_getMost_backend_aptGetInstall tar
	_getMost_backend_aptGetInstall xz
	_getMost_backend_aptGetInstall gzip
	_getMost_backend_aptGetInstall bzip2
	
	_getMost_backend_aptGetInstall flex
	
	_getMost_backend_aptGetInstall librecode0
	_getMost_backend_aptGetInstall wkhtmltopdf
	
	_getMost_backend_aptGetInstall sed
	
	
	_getMost_backend_aptGetInstall curl
	
	_messagePlain_probe 'install: rclone'
	_getMost_backend curl https://rclone.org/install.sh | _getMost_backend bash -s beta
	
	
	
	_getMost_backend_aptGetInstall sockstat
	_getMost_backend_aptGetInstall liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common
	
	#_getMost_backend_aptGetInstall octave
	#_getMost_backend_aptGetInstall octave-arduino
	#_getMost_backend_aptGetInstall octave-bart
	#_getMost_backend_aptGetInstall octave-bim
	#_getMost_backend_aptGetInstall octave-biosig
	#_getMost_backend_aptGetInstall octave-bsltl
	#_getMost_backend_aptGetInstall octave-cgi
	#_getMost_backend_aptGetInstall octave-communications
	#_getMost_backend_aptGetInstall octave-control
	#_getMost_backend_aptGetInstall octave-data-smoothing
	#_getMost_backend_aptGetInstall octave-dataframe
	#_getMost_backend_aptGetInstall octave-dicom
	#_getMost_backend_aptGetInstall octave-divand
	#_getMost_backend_aptGetInstall octave-econometrics
	#_getMost_backend_aptGetInstall octave-financial
	#_getMost_backend_aptGetInstall octave-fits
	#_getMost_backend_aptGetInstall octave-fuzzy-logic-toolkit
	#_getMost_backend_aptGetInstall octave-ga
	#_getMost_backend_aptGetInstall octave-gdf
	#_getMost_backend_aptGetInstall octave-geometry
	#_getMost_backend_aptGetInstall octave-gsl
	#_getMost_backend_aptGetInstall octave-image
	#_getMost_backend_aptGetInstall octave-image-acquisition
	#_getMost_backend_aptGetInstall octave-instrument-control
	#_getMost_backend_aptGetInstall octave-interval
	#_getMost_backend_aptGetInstall octave-io
	#_getMost_backend_aptGetInstall octave-level-set
	#_getMost_backend_aptGetInstall octave-linear-algebra
	#_getMost_backend_aptGetInstall octave-lssa
	#_getMost_backend_aptGetInstall octave-ltfat
	#_getMost_backend_aptGetInstall octave-mapping
	#_getMost_backend_aptGetInstall octave-miscellaneous
	#_getMost_backend_aptGetInstall octave-missing-functions
	#_getMost_backend_aptGetInstall octave-mpi
	#_getMost_backend_aptGetInstall octave-msh
	#_getMost_backend_aptGetInstall octave-mvn
	#_getMost_backend_aptGetInstall octave-nan
	#_getMost_backend_aptGetInstall octave-ncarry
	#_getMost_backend_aptGetInstall octave-netcdf
	#_getMost_backend_aptGetInstall octave-nlopt
	#_getMost_backend_aptGetInstall octave-nurbs
	#_getMost_backend_aptGetInstall octave-octclip
	#_getMost_backend_aptGetInstall octave-octproj
	#_getMost_backend_aptGetInstall octave-openems
	#_getMost_backend_aptGetInstall octave-optics
	#_getMost_backend_aptGetInstall octave-optim
	#_getMost_backend_aptGetInstall octave-optiminterp
	#_getMost_backend_aptGetInstall octave-parallel
	#_getMost_backend_aptGetInstall octave-pfstools
	#_getMost_backend_aptGetInstall octave-plplot
	#_getMost_backend_aptGetInstall octave-psychtoolbox-3
	#_getMost_backend_aptGetInstall octave-quarternion
	#_getMost_backend_aptGetInstall octave-queueing
	#_getMost_backend_aptGetInstall octave-secs1d
	#_getMost_backend_aptGetInstall octave-secs2d
	#_getMost_backend_aptGetInstall octave-secs3d
	#_getMost_backend_aptGetInstall octave-signal
	#_getMost_backend_aptGetInstall octave-sockets
	#_getMost_backend_aptGetInstall octave-sparsersb
	#_getMost_backend_aptGetInstall octave-specfun
	#_getMost_backend_aptGetInstall octave-splines
	#_getMost_backend_aptGetInstall octave-stk
	#_getMost_backend_aptGetInstall octave-strings
	#_getMost_backend_aptGetInstall octave-struct
	#_getMost_backend_aptGetInstall octave-symbolic
	#_getMost_backend_aptGetInstall octave-tsa
	#_getMost_backend_aptGetInstall octave-vibes
	#_getMost_backend_aptGetInstall octave-vlfeat
	#_getMost_backend_aptGetInstall octave-rml
	#_getMost_backend_aptGetInstall octave-zenity
	#_getMost_backend_aptGetInstall octave-zeromq
	#_getMost_backend_aptGetInstall gnuplot-qt libdouble-conversion3 libegl-mesa0 libegl1 libevdev2 libinput-bin libinput10 libmtdev1 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libwacom-bin libwacom-common libwacom2 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-util1 libxcb-xinerama0 libxcb-xinput0 libxcb-xkb1 libxkbcommon-x11-0 qt5-gtk-platformtheme qttranslations5-l10n
	#_getMost_backend_aptGetInstall hdf5-helpers libaec-dev libegl-dev libfftw3-bin libfftw3-dev libfftw3-long3 libfftw3-quad3 libgl-dev libgl1-mesa-dev libgles-dev libgles1 libgles libglvnd-dev libglx-dev libhdf5-cpp-103 libhdf5-dev liboctave-dev libopengl-dev libopengl0
	
	
	_getMost_backend_aptGetInstall axel
	
	_getMost_backend_aptGetInstall dwarves
	
	
	_getMost_backend_aptGetInstall rsync
	
	
	_getMost_backend_aptGetInstall libssl-dev
	
	
	# May not be useful for anything, may cause delay or fail .
	#_getMost_backend apt-get upgrade
	
	
	
	"$scriptAbsoluteLocation" _test
	
}



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




_fetchKernel-lts() {
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

_fetchKernel-mainline() {
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






_buildKernel-lts() {
	_messageNormal "init: buildKernel-lts: ""$currentKernelPath"
	make olddefconfig
	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	make deb-pkg -j $(nproc)
	[[ "$?" != "0" ]] && _messageFAIL
	
	return 0
}

_buildKernel-mainline() {
	_messageNormal "init: buildKernel-mainline: ""$currentKernelPath"
	make olddefconfig
	_kernelConfig_desktop ./.config | tee "$scriptLocal"/mainline/statement.sh.out.txt
	cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/mainline/
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	make deb-pkg -j $(nproc)
	[[ "$?" != "0" ]] && _messageFAIL
	
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
_upload_lts() {
	_rclone_limited copy "$scriptLocal"/_export/linux-lts-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}

# ATTENTION: Override with 'ops.sh' or similar!
_upload_mainline() {
	_rclone_limited copy "$scriptLocal"/_export/linux-mainline-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}


_create_lts() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_lts
	
	_export_cloud_lts
	
	_upload_lts
	
	cd "$functionEntryPWD"
	_stop
}

_create_mainline() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_mainline
	
	_export_cloud_mainline
	
	_upload_mainline
	
	cd "$functionEntryPWD"
	_stop
}





_refresh_anchors() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_prepare
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_fetchKernel
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud
}



