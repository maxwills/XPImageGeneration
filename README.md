# Object-Centric Debugging experiment

This experiment occurs in the context of the French ANR project ANR JCJC OCRE Object-Centric debugging REloaded (https://anr.fr/Project-ANR-21-CE25-0004).

During this experiment, we ask you to complete a set of tasks using the Pharo object-centric debugging tools (https://pharo.org/).
We collect anonymous data and surveys that are automatically sent to a server hosted by Inria (https://www.inria.fr/en).

**IMPORTANT: To avoid biasing the results of the experiment, please do not communicate any information about it to someone else.**

**PLEASE FOLLOW WITH GREAT ATTENTION THE INSTRUCTIONS BELOW**.

## Your participation

If at any point you decide to stop the experiment, just quit the Pharo development environment.
Because your data will be incomplete, it will be deleted during the data processing phase.

When you complete the experiment to the end, the development environment automatically closes.
After that point, because your session is over and your data is anonymized, we won't be able to cancel your participation as it will be impossible to find which data is yours.

**You need an internet connection to participate to the experiment.** 
Be careful if you do that from your office: some network configurations have firewalls that block the data sending.

## Environment

This experiment is a controlled experiment using the Pharo 9 base image.
You should not under any circumstance load or use other tools than the ones provided into the system.
Data showing external interference (such as loading or using external tools) will be considered invalid and thus discarded.

However, you are free to use everything you have at your disposal in the Pharo 9 base image.
  
## Set-up

Download and open the Pharo Launcher here: https://pharo.org/download

Create a new image:

![Create a new image](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/create-image.png)

In the deprectated distribution list, select Pharo 9 (choose 32 or 64bits depending on your system):

![Select P9](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/select-p9-new.png)

Make sure you have the latest VM for Pharo 9.
Go to VMs, select the Pharo 9 line, right click and select *update*:
![Update VM](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/vm-update.png)

Select the newly created image in the list then click "start":

![Start image](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/start-image.png)

In Pharo, left click on the environment background, and select `Browse > Playground` in the menu:

![Open playground](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/playground.png)


Copy paste the following lines in the Playground, then select them, right-click to open the contextual menu, then select `Do it`:

```Smalltalk
Metacello new
	baseline: 'XPImageGeneration';
	repository: 'github://Pharo-XP-Tools/XPImageGeneration:exp-ocd';
	load.
```


![Doit baseline](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/baseline.png)

On Windows 11 there is sometimes a `Path too long` when cloning a git repository.
If that happens, you can try to enable support for long paths (for example, see https://helpdeskgeek.com/windows-11/how-to-fix-the-path-too-long-error-on-windows/).
If it does not work you cannot do the experiment, or you have to use another system (such as Linux).

# Instructions
## Starting the experiment

- When the experiment is loaded, an agreement window opens. You have to read carefully the agreement and accept it to continue the experiment. As soon as you accept the agreement, the system starts sending anonymous data to the experiment server.
- Once you accepted the experiment, a list of tasks appears. You have to do these tasks in order in the list (start by the first in the list). **You cannot choose the order of the tasks.** Please follow **carefully** the instructions from the tasks. Especially, since the point is to evaluate a tool, if the tasks requires you to use object-centric tools please try to use them even though you might not use them all the time.

## Starting tasks
- To start a task, select that task then click "start". The description of the task appears on the side panel.
- When you browse the text of a task description, clicking on a link browses the class or method it points to (in blue in the text).

## Finishing tasks
- Once you believe you finished a task, select the task then click "finish". A window opens to finalize the task, and ask you for an answer.
- Provide the answer that you can, as best as you can, if you believe you did not solve the bug, please try to explain what you understood and where you stopped your investigation and why.
- If you cannot or do not want to finish a task, but still want to continue the experiment, you can finish the task and go to the next one. Just provide an answer to explain the data, for example: "*I did not finish the task because I cannot find the problem*, or *I do not wish to finish the task* (you do not have to give a reason, but if for example you run out of time you can tell. You can also finish a task because you arrived at a conclusion that is not the answer, but that is the best that you can do in the time you can allow to your participation. In that case, just specify it in the answer.
- After finalizing a task, one or more surveys windows may open. Please try to answer to all questions. Unless specifically required, do not provide personal information in the free text fields. Some surveys might look the same, but look more closely: they are different.

## Interruptions and crashes
- We prefer that you avoid interruptions during the experiment. The experiment should last between 45min and 2h (it never went shorter nor longer). If you get interrupted, please take note of how much time you were interrupted and report it in the surveys when requested.
- Since you are going to do program comprehension and debugging tasks, you might perform actions that render the system unstable. If you freeze your Pharo image during the experiment, just quit and restart the image.

## Personal data

We do not collect automatically any data that would allow for the identification of participants.

We automatically collect technical data (*e.g.*, a breakpoint was hit) that is anonymized, encrypted and transfered to an Inria secured server.

The controlled experiment might be followed by interviews of participants by researchers from the University of Zurich.
Participating to interviews is optional. 
In the sole case where you would like to participate to an interview, the last survey of the experiment will ask you to provide an email address, that will be transfered to the University of Zurich who will contact you later.

