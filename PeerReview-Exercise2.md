# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Ty Matson
* *email:* thmatson@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock camera works as specified in the instructions. There are a couple exported fields but having additional functionality is not bad.

___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
This implementation seems to follow the instructions for stage 2 (and even made me realize I might have made a mistake in my own implementation).

___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera appears to properly follow the vessel around the screen and catchup at a faster rate when the vessel is no longer moving.

___
### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera leads the vessel as instructed. They also accounted for the hyperspeed affecting how the camera and vessel work.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [X] Unsatisfactory

___
#### Justification ##### 
Unfortunately there is no implementation for stage 5.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
In multiple declarations of float variabales, a decimal value was not provided. This can be seen in [this line](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/position_lock.gd#L6) where they set a float equal to 5 instead of 5.0, although it is good they let the compiler know to treat it as a float. This can also be seen when declaring and initializing a Vector2 (which contains 2 floats) in [this line](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/auto_scroll.gd#L6). This is inconsistent with the style guide and inconsistent with [the line directly after it](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/auto_scroll.gd#L7), which correctly styles the floats as having decimal places.

A similar infraction can be seen [on this line](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L27) where they compare the float variable timer to the integer 0. Although this will always work because the compiler can compare floats and ints (or maybe it converts ints to floats when doing float comparisons), but it would be more clear to have `if timer > 0.0` instead. This same comparison is repeated [later in this script](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L38).

#### Style Guide Exemplars ####
Every script created for this project seems to follow the variable naming schemes outlined in the Godot style guide. All of the public/export variables are in snake case and the class_name for each script is in Pascal case, while the file name for those scripts are in snake case, as they should be.

The ordering of functions inside the scripts also follow the style guide, with built in private functions like _ready and _process coming before the publicly declared functions. 

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
There are a few places in the code containing commented lines that subtract from the cleanliness of the code. One such instance can be found [here](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/position_lerp.gd#L30) where they did not delete what appears to be old code functionality. This can also be seen multiple times in the auto_scroll.gd script, with the first occurrence [here](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/auto_scroll.gd#L27). The best practice infractions in this script are just print statements that were probably used for debugging, but I think it is best to delete those commented out lines or other debug lines when submitting a project.

I also noticed that there are little to no comments letting the user know what the code is accomplishing, which could be hard for someone to follow if they were not knowledgable about the project. It is also good to put comments in case you need to come back to the code and want to know exactly what it is doing.

In the [lerp_target_focus](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L26) script, the variable direction_to_target was declared but never used, so it should probably be deleted.

#### Best Practices Exemplars ####
There is good spacing between sections of code for better readability. The only times there are long stretches of code without empty lines is when it is necessary, like for a section of if, elif statements.

The variable names are also very informative of what the variables are supposed to hold, which makes it a lot easier to read the code, as if it's just English. For instance, [this variable](https://github.com/ensemble-ai/exercise-2-camera-control-dmedina0223/blob/d9111c43c7e5a1dad74dbd140a4ecf5c11c7dd42/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L10) would be a lot less informative if it were named something more shorthand like `delay_dur`, especially for someone from the outside that did not write the code, or even for the user to come back to after months of not looking at the project.