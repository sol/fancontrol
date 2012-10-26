> tl;dr Make sure that you understand the code before using this.  Use at your
> own risk!

Use `sensors` or `cat /proc/acpi/ibm/thermal` to see your systems current
thermal state.

Make sure that 

    cat /proc/acpi/ibm/

lists the `watchdog` and `level` command.  If it does not, enable them with:

    sudo -c 'echo options thinkpad_acpi experimental=1 fan_control=1 > /etc/modprobe.d/thinkpad_acpi.conf'
    subo reboot
