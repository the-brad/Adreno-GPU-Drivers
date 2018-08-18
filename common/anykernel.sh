# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# reinitialize needed vars and functions
INSTALLER=<INSTALLER>
OUTFD=<OUTFD>
BOOTMODE=<BOOTMODE>
DEBUG=<DEBUG>
MAGISK=<MAGISK>
slot=<SLOT>
INSTALL=true

ui_print() {
  $BOOTMODE && echo "$1" || echo -e "ui_print $1\nui_print" >> /proc/self/fd/$OUTFD
}

. $INSTALLER/config.sh
. $INSTALLER/common/unityfiles/util_functions.sh
api_level_arch_detect

# shell variables
ramdisk_compression=auto
block=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. $INSTALLER/common/unityfiles/tools/ak2-core.sh

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*
chown -R root:root $ramdisk/*

#DEBUG
if $DEBUG; then
  $BOOTMODE || exec 3>&1 1>&2 2>&3 2>/data/media/0/$MODID\AK2-log.log
  set -x
fi

## AnyKernel install
ui_print "   Unpacking boot image..."
ui_print " "
dump_boot

# File list - only needed for slot devices. Place every file you will modify with relative path to root in the list variable
# See here for more details: https://forum.xda-developers.com/showpost.php?p=71924246&postcount=451
list=""
[ "$slot" -a "$list" ] && slot_device

# begin ramdisk changes
ui_print "   Modifying boot img..."

#end ramdisk changes
ui_print "   Repacking boot image..."
write_boot

# end install
