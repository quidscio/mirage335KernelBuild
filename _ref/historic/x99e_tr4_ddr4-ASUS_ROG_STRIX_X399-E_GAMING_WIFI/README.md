


Linux kernel 'lts_5.10.61-intel' . Config file in this directory. Relatively stable and functional across many machines.
IIRC (mirage335), the 'AMD' specific kernel was never required or used in production.


Some Intel machines may have had uptime exceeding months without incident.


AMD machine based on X339-E chipset and ThreadRipper 1950x CPU may have had an average uptime of three weeks, with graphics corruption incidents necessitating at least X server reset if not reboot.
Kernel command line parameters may have included:
"quiet amdgpu.pcie_gen2=0 systemd.log_level=debug systemd.log_target=kmsg log_buf_len=1M printk.devkmsg=on enforcing=0 printk_ratelimit=0 printk_ratelimit_burst=3600"
Kernel command line parameters for experiment or older kernel, not used with mentioned kernel or not used in production may have included:
quiet amdgpu.pcie_gen2=0 amdgpu.ppfeaturemask=0xffffffff
pci=nomsi,noaer
amdgpu.dc=1 pci=nomsi,noaer
quiet loglevel=0 amdgpu.dc=1
quiet amdgpu.pcie_gen2=0


_ Reference _

https://www.amazon.com/STRIX-GAMING-Threadripper-Motherboard-802-11AC/dp/B0756VTD19
 'ASUS ROG STRIX X399-E GAMING AMD Ryzen Threadripper TR4 DDR4 M.2 U.2 X399 EATX HEDT Motherboard with onboard 802.11AC WiFi, USB 3.1 Gen2, and AURA Sync RGB Lighting '






