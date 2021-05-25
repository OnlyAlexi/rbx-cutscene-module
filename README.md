# rbx-cutscene-module
Is there any real reason to use this over a cutscene creating plugin? Not really.
However, it would be easy for someone with no prior programming experience to use this.
I decided to make it completely for means of practice a while ago, it has some poor practices because some of it is pretty old code and I only very recently went back to the project to finish it. 

##Documentation

###rcm.L_PANCAMERA_QUEUE(original_instance, new_instance, time)
Places a camera-pan movement into the queue, on execution of the movement the camera will pan from "original_instance" to "new_instance" and take "time" to complete the movement.
