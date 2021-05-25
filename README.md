# rbx-cutscene-module
Is there any real reason to use this over a cutscene creating plugin? Not really.
However, it would be easy for someone with no prior programming experience to use this.
I decided to make it completely for means of practice a while ago, it has some poor practices because some of it is pretty old code and I only very recently went back to the project to finish it. 

## How does it work?
A series of functions found in the documentation below adds different camera-movements like pans, cuts, zooms and dialogue into the queue.
A seperate function is then used to run the queue and one by one, each camera movement will be executed and the queue will then be cleared.

## Documentation


### rcm.L_PANCAMERA_QUEUE(original_instance, new_instance, time_before_next_action)
Places a camera-pan movement into the queue, on execution of the movement the camera will pan from "original_instance" to "new_instance" and take "time" to complete the movement.
```
rcm.L_PANCAMERA_QUEUE(workspace.Malenz.Head, workspace.Part, 2) 
-- Will pan from the given players head to the part at a speed relative to 2 seconds.
```


### rcm.L_CUTCAMERA_QUEUE(instance, time_before_next_action, offset, instant)
```
rcm.L_CUTCAMERA_QUEUE(workspace.Noob.Head,2,1, false)
-- Will cut the camera to the given "Noobs" head and then wait 2 seconds before the next action
-- The camera will be placed 1 stud away from the front-face (can be configured to other faces)
-- The last argument should be set to false if you have dialogue after the cut.
```

### rcm.TE_SPELL_DIAGLOGUE(text, instance, time_before_next_action)
```
rcm.TE_SPELL_DIAGLOGUE("U SUCK", rcm.L_PLAYER ,2)
-- Places a textbox above the given instance (in this case, the local players head) and types it out
-- Afterwards, it waits "time" before going to the next action
```

### rcm.L_ZOOM_QUEUE(zoom_amount, time_before_resetting_zoom, reset_fov, time_before_next_action)
```
rcm.L_ZOOM_QUEUE(40,3, true, 1)
-- Zooms in by decreasing the cameras FOV by 40, waiting a second before resetting it to default.
-- Then waiting 3 seconds before moving to the next camera action.
```
### rcm.FN_CUTSCENE_D()
```
rcm.FN_CUTSCENE_D()
-- Ends the cutscene, sets the camera-subject back to local player.
-- Clears the queue-table allowing room for the next cutscene.
```

### rcm.EF_FADE_OUT(time_before_removal)
```
rcm.EF_FADE_OUT(3)
-- After fading out will wait 3 seconds before removing the black-screen.
```

## Variables/Configuration

#### rcm.ENABLE_BLACK_BARS
If set to true, black cinematic bars will appear at the bottom and top of the screen during cutscenes.
These are removed when the FN_CUTSCENE_D function is used.

#### rcm.L_PLAYER
Shortcut to the local players head for cutscene purposes. Example:
```rcm.TE_SPELL_DIAGLOGUE("U SUCK", rcm.L_PLAYER ,2)
--rcm.L_PLAYER is used in place of an object, will use the players head.
```
