##### Core


_test_build_cloud() {
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
	
	_test_kernelConfig
}

_build_cloud() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_test_build_cloud
	"$scriptAbsoluteLocation" _setupUbiquitous_nonet
	
	
	
	
	
	local kernelURL
	local kernelName
	mkdir -p "$scriptLocal"/lts
	cd "$scriptLocal"/lts
	#kernelURL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.61.tar.xz"
	kernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep '5\.10' | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	kernelName=$(_safeEcho_newline "$kernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	
	wget "$kernelURL"
	
	
	
	
	
	
	
	
	
	
	
	mkdir -p "$scriptLocal"/mainline
	
	
	
	_stop
	cd "$functionEntryPWD"
}

