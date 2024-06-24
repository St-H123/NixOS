## Loads the settings needed for a WSL system.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    module-settings = (builtins.trace "Loading: ${toString ./.}..." machine-settings.system.modules.wsl); 

in ( if module-settings.enable == true then {

    wsl.enable = true;
    wsl.defaultUser = wsl-settings.defaultUser;

} else {} )
