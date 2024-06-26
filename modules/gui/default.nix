## imports the right GUI as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 
  
    importNothing = {};

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    gui = ( builtins.trace "gui module with GUI requested: ${machine-settings.modules.gui}" (
            builtins.trace "Loading: ${toString ./.}..." machine-settings.modules.gui
        ) 
    ); 

in 

#! The gui must be specified in the variable !#
assert ( gui != "" && gui != false); 
#! The gui must be specified in the variable !#

{ imports = [(    

        if ( gui == "i3" || gui == "i3wm"            ) then ( import ./i3wm     arguments ) else 
        if ( gui == "gnome"                          ) then ( import ./gnome    arguments ) else
        if ( gui == "kde" || gui == "KDE"            ) then ( import ./kde      arguments ) else
        if ( gui == "hyprland" || gui == "hyperland" ) then ( import ./hyprland arguments ) else 
        if ( gui == "none" || gui == false           ) then ( importNothing               ) else 
        abort "Error: \"${gui}\" is not one of the supported GUIs."

    )];
}
