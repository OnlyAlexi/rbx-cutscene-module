# rbx-cutscene-module
Is there any real reason to use this over a cutscene creating plugin? Not really.
However, it would be easy for someone with no prior programming experience to use this.
I decided to make it completely for means of practice a while ago, it has some poor practices because some of it is pretty old code and I only very recently went back to the project to finish it. 

## How does it work?
A series of functions found in the documentation below adds different camera-movements like pans, cuts, zooms and dialogue into the queue.
A seperate function is then used to run the queue and one by one, each camera movement will be executed and the queue will then be cleared.

## Documentation


### rcm.L_PANCAMERA_QUEUE(original_instance, new_instance, time)
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

