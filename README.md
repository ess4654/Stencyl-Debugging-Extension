# Stencyl-Debugging-Extension
#### An extension for the Stencylworks game engine that adds better functionality for debugging

My number one complaint with Stencyl is the lack of features to allow for in game testing, so I made this extension to add an in game console to your project!

![Debugging Header](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/header.png "Debugging Header")

### Enable Debugging
![Enable Debugging](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/enable_debugging.png "Enable Debugging")

**(MUST BE CALLED FIRST)** This block will enable/disable the debugging functionality. Debugging console can be turned on and off with the use of the key set with Debug Console Key. This block will prevent the key from opening the console.

### Is Debugging
![Is Debugging](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/debugging.png "Is Debugging")

This will return whether or not the debugging console is open.

### Set Console Key
![Set Console Key](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/set_console_key.png "Set Console Key")

This block will set the key that opens the console and toggles in game debug mode.

### Set Console Text
![Set Console Text](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/set_console_text.png "Set Console Text")

Change the text that the console will use. 

### Print Console to Screen
![Print Console](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/print_console.png "Print Console")

This block must be called in Drawing function to show console contents on the screen. Note: Check Key State block does npt need to be used when this block is added to code. To use debug features without the console use the Check Key State block instead.

### Console Log
![Console Log](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/console_log.png "Console Log")

Print anything in console.

### Clear Console
![Console Clear](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/clear_console.png "Console Clear")

Clears the console of any logged items.

### Show Frames Per Second
![FPS](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/enable_fps_draw.png "FPS")

Toggles the Frames Per Second output in console. Default is true.

### Show Number of Actors
![Show Actors](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/show_num_actors.png "Show Actors")

This block can show both the number of actors currently on screen and the number of actors in the scene in the console window.

### Check Key State
![Check Key State](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/check_key_state.png "Check Key State")

This block will check the state of the debugging keys without opening the console window. If Print Console to Screen Block is used in Drawing function, this block does not need to be used to get keyboard updates.

### Set Debug Key
![Set Debug Key](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/set_debug_key.png "Set Debug Key")

Debugging allows for up to 10 hotkeys assigned. The state of each key can be checked using the state block and will always return false if the debugging console is closed. Note: If you require the use of more then 10 keys for debugging purposes, please message me and I can add additional keys to the extension.

### Get Debug Key State
![Get Key State](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/debug_key_state.png "Get Key State")

This will return the state of one of the 10 hotkeys. Useful for doing stuff in game to test while debugging console is open.
#### A few examples of a good use for this block are:

• A button to unlock all powerups in a level

• A key to make player invincible to enemies

• Increase/Decrease time in a game with a countdown clock

• Fly through level with 8 way movement

### Formatted Coordinate
![Coordinate](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/formatted_coordinate.png "Format Coordinate")

Returns a nicley formatted X, Y Coordinate with a text field for naming.

### Formatted Vector
![Vector](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/get_formatted_vector.png "Format Vector")

Returns a nicley formatted X, Y, Z Vector with a text field for naming.

### Key Value
![Key Value](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/key_value.png "Format Key Value")

Returns a nicley formatted Key Value pair.

### Logic Condenser
![Logic](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/logic_condenser.png "Logic Condenser")

Useful shortcut for setting values that is faster then an if else statement. If the boolean value is true, the first value is returned otherwise the last value will be returned.

### Print List
![Print List](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/print_list.png "Print List")

Print each item of a list to the console with index value.

### Print 2D Array
![2D Array](https://raw.githubusercontent.com/ess4654/Stencyl-Debugging-Extension/master/block-images/print_2d_array.png "Print 2D Array")

Given a valid 2D list, the contents will be printed to the console.

## Last Updated April 1, 2020 v1.0

Additional Notes: Debug Drawing will always be on if the console is open. The use of in game block can disable it.

Contact Me: thejoblesscoder@gmail.com

Extension is Open Sourced and Licensed under MIT open source standards.
