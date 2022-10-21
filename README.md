# Object-Centric Debugging experiment

This experiment occurs in the context of the French ANR project ANR JCJC OCRE Object-Centric debugging REloaded (https://anr.fr/Project-ANR-21-CE25-0004).

During this experiment, we ask you to complete a set of tasks using the Pharo object-centric debugging tools (https://pharo.org/).
We collect anonymous data and surveys that are automatically sent to a server hosted by Inria (https://www.inria.fr/en).

To participate to the experiment, please follow the instructions below.

If at any point you decide to stop the experiment, just quit the Pharo development environment.
Because your data will be uncomplete, it will be deleted during the data processing phase.

When you complete the experiment to the end, the development environment automatically closes.
After that point, because your session is over and your data is anonymized, we won't be able to cancel your participation as it will be impossible to find which data is yours.
  
## Set-up

Download and open the Pharo Launcher here: https://pharo.org/download

Create a new image:

In the official distribution list, select Pharo 9 (choose 32 or 64bits depending on your system):

In Pharo, left click on the environment background, and select `Browse > Playground` in the menu:

Copy paste the lines below, then select it, right-click to open the contextual menu, then select `Do it`:

```Smalltalk
Metacello new
	baseline: 'XPImageGeneration';
	repository: 'github://Pharo-XP-Tools/XPImageGeneration:exp-ocd';
	load.
```
Select the newly created image in the list then click "start":
*missing screenshot*

## Starting the experiment

- Agreement else it's over
- List of task to do in order (start by the first in the list)
- clicking on a link browses the class or method
- provide the answer that you can, as best as you can, if you believe you did not solve the bug, please try to explain what you understood and where you stopped your investigation and why
- finsih task when finished
- you can save the image and continue later, however avoid that or retain the time you interrupt the experiment
- if freeze, just restart the image

