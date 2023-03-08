# 65816 VGA Card
This is a simple VGA Expansion card designed for my 65816 SBC<br>
It uses an `ATF1508AS` CPLD for all the Logic, and 4x `IDT7005S` or `IDT7006S` Dual Port SRAM ICs for a total of either 32kB or 64kB of VRAM. (or something inbetween)

the Logic uploaded here is for 32kB of VRAM, 640x400 Monochrome (1 bit per pixel or "bpp") with an Interrupt every time a frame finished drawing.<br>
Though once i get my hands on some 16kB Chips i'll likely do a few more versions of the Logic and also upload them here.

# Folders
* "Downloaded Libs" contains the symbols and footprints for the KiCad Project
* "Logic" contains the... well Logic for the entire thing. i've included the original .dig file (requires [Digital](https://github.com/hneemann/Digital) to open), and already generated .v (Verilog) and .pof/.jed (program files in case you want to skip setting up Quartus to generate them yourself)
* "Gerbers" contains all required Gerbers to order yourself the PCB

# Misc

regards to the Logic:
the `CA13` line (CPU Address bit 13) is only required when dealing with 8kB DP-SRAM Chips,<br>
and the `VA13` (Video Address bit 13) line is only required when dealing with 16kB DP-SRAM Chips.<br>
also right now the decoding logic puts the VRAM on the CPU side at address `$FF8000`
