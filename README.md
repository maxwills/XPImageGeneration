# Object-Centric Debugging experiment

This experiment occurs in the context of the French ANR project ANR JCJC OCRE Object-Centric debugging REloaded (https://anr.fr/Project-ANR-21-CE25-0004).

During this experiment, we ask you to complete a set of tasks using the Pharo object-centric debugging tools (https://pharo.org/).
We collect anonymous data and surveys that are automatically sent to a server hosted by Inria (https://www.inria.fr/en).

To participate to the experiment, please follow the instructions below.

If at any point you decide to stop the experiment, just quit the Pharo development environment.
Because your data will be uncomplete, it will be deleted during the data processing phase.

When you complete the experiment to the end, the development environment automatically closes.
After that point, because your session is over and your data is anonymized, we won't be able to cancel your participation as it will be impossible to find which data is yours.

**You need an internet connection to participate to the experiment.**
  
This experiment is a controlled experiment using the Pharo 9 base image.
You should not under any circumstance load or use other tools than the ones provided into the system.
Data showing external interference (such as loading or using external tools) will be considered invalid and thus discarded.

However, you are free to use everything you have at your disposal in the Pharo 9 base image.
  
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

- When the experiment is loaded, an agreement window opens. You have to read carefully the agreement and accept it to continue the experiment. As soon as you accept the agreement, the system starts sending anonymous data to the experiment server.
- Once you accepted the experiment, a list of tasks appears. You have to do these tasks in order in the list (start by the first in the list). Please follow carefully the instructions from the tasks. Especially, since the point is to evaluate a tool, if the tasks requires you to use object-centric tools please try to use them even though you might not use them all the time.
- To start a task, select that task then click "start". The description of the task appears on the side panel.
- When you browse the text of a task description, clicking on a link browses the class or method it points to (in blue in the text).
- Once you believe you finished a task, select the task then click "finish". A window opens to finalize the task, and ask you for an answer.
- Provide the answer that you can, as best as you can, if you believe you did not solve the bug, please try to explain what you understood and where you stopped your investigation and why.
- After finalizing a task, one or more surveys windows may open. Please try to answer to all questions. Unless specifically required, do not provide personal information in the free text fields.
- If you are interrupted during the experiment, you can save the image and continue later. However we prefer that you avoid that. The experiment should last between 1h and 1h30. If you get interrupted, please take not of how much time you were interrupted.
- Since you are going to do program comprehension and debugging tasks, you might perform actions that render the system unstable. If you freeze your Pharo image during the experiment, just quit and restart the image.



