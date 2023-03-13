Class {
	#name : #ObjectCentricDebuggingExperiment,
	#superclass : #DefaultGithubBasedExperiment,
	#instVars : [
		'validator',
		'participantUUID'
	],
	#classVars : [
		'DevelopmentMode'
	],
	#category : #'Experiments-OCDbg'
}

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildContactAndCommentSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title:
		'Experiment Feedback (Perceived usefulness, Ease of Use, and self prediction of future use)'.

	survey addQuestion: (self freeTextQuestion:
			 'If you have any comments on the experiment, please add them here').

	survey addQuestion: (self freeTextQuestion:
			 'If you would be informed about the results of this work, please add your e-mail').

	survey addQuestion: (self freeTextQuestion:
			 'If you would participate in a more detailed interview, please add your e-mail').

	survey addQuestion:
		(self yesNoQuestion:
			 'Do you authorize the publication of these data?').

	^ survey
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildDemographicSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title: 'Demographic information'.

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'What is your highest achieved level of education?'
			 options: #( 
			'High School but did not graduate' 
			'High School graduate or GED'			 	     
			'Some college or 2-year degree' 
			'Bachelor in CS (Computer Science)'
			'Bachelor in STEM (Science, Technology, Engineering and Mathematics)'
			'Bachelor in a different area than CS or STEM' 
			'Master in CS'
			'Master in STEM' 
			'Master in a different area than CS or STEM'
			'PhD or higher academic title in CS' 
			'PhD or higher academic title in STEM'
			'PhD or higher academic title in a different area than CS or STEM')).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'What is you current job position?'
			 options: #( 
			'Student' 
			'Part-Time Dev'
			'Full-Time Dev' 
			'Unemployed'
			'Self-Employed' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How many years of programming experience do you have?'
			 options:
			 #( '< 1' '1-2 years' '3-5 years' '6-10 years' 'More than 10' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How many years of programming experience do you have with Pharo?'
			 options:
			 #( '< 1' '1-2 years' '3-5 years' '6-10 years' 'More than 10' )).

	survey addQuestion: (self
			 singleChoiceQuestion: 'How often do you write code?'
			 options: #( 'At least once per day' 'At least once per week'
				    'At least once per month' 'At least once per year' )).

	survey addQuestion: (self
			 singleChoiceQuestion: 'How often do you write code in Pharo?'
			 options: #( 'At least once per day' 'At least once per week'
				    'At least once per month' 'At least once per year' )).


	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with the sentence: "I''m familiar with debugging"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with the sentence: "I''m familiar with Object-Centric Debugging"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildExperiment [
	<script>
	| tasks postTaskSurvey surveys xp |
	tasks := self buildTasks.
	surveys := self buildExperimentSurveys.

	postTaskSurvey := self buildPostTaskSurvey.
	surveys add: postTaskSurvey.
	tasks first survey: postTaskSurvey uuid.

	postTaskSurvey := self buildPostTaskSurvey.
	surveys add: postTaskSurvey.
	tasks last survey: postTaskSurvey uuid.

	xp := self basicNew.
	xp tasks: tasks.
	1 to: surveys size do:[:i| (surveys at: i) order: i]. 
	surveys do:[:s| xp addSurvey: s].
	xp serializeTasks.
	xp serializeSurveys.
	xp inspect
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildExperimentSurveys [

	| svs |
	svs := OrderedCollection new.
	svs add: self buildIntroSurvey.
	svs add: self buildDemographicSurvey.
	svs add: self buildPostExperimentSurvey.
	svs add: self buildContactAndCommentSurvey.
	^svs
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildIntroSurvey [
	|textStream question survey |
	textStream := WriteStream on: String new.
	textStream << 'Dear Participant,'.
	textStream cr.
	textStream << 'We are researchers investigating on Object-Centric debugging (OCDbg). We would be grateful if you could help our research and participate in our experiment on this subject.'.
	textStream cr.
	textStream cr.
	textStream << 'In this experiment:'.
	textStream cr.
	textStream << '- We analyze developers applying OCDbg in different circumstances,'.
	textStream cr.
	textStream << '- we collect and store anonymized data from you during the experiment.'.
	textStream cr.
	textStream cr.
	textStream << 'The experiment will require around 40 minutes to be completed.'.
	textStream cr.
	textStream cr.

	textStream << 'To proceed, please carefully read and agree to the following data handling policy:'.
	textStream cr.
	textStream cr.
	textStream << 'In this experiment, we ask you some demographic data such as your level of education and your experience as a developer. None of these questions will be mandatory and we will not ask any further sensitive information. Please do not to share personal and/or sensitive information in the open questions you will find in the experiment. In such a case, we will remove your answer from the final dataset.'.
	textStream cr.
	textStream cr.
	textStream <<		
		'Your answers are anonymized to the best of our capabilities, moreover the IP address from which you complete the experiment is not saved. You can withdraw from the experiment at any moment by quitting the experimental environment; any uncomplete data will be removed. All the data are used for research purposes only; the data will not be sold or shared to third parties.'.

	textStream cr.
	textStream cr.
	textStream <<'The data handling and storing is under the responsibility of Steven Costiou, Inria Lille - Nord Europe, contact: steven.costiou@inria.fr
	The data analysis is under the responsibility of Alberto Bachelli, University of Zurich, contact: bacchelli@ifi.uzh.ch'.
	textStream cr.
	textStream << 'Do you agree with or Data Policy Content? *If you do not agree, please leave the experiment*'.
	
	question := PhexAgreementQuestion new
		  title: textStream contents;
		  yourself.
	survey := PhexSurvey agreementSurvey.
	survey title: 'Experiment introduction and data policy.'.
	survey questions: { question }.
	^ survey
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildPostExperimentSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title:
		'Experiment Feedback (Perceived usefulness, Ease of Use, and self prediction of future use)'.

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Experiment was easy." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Experiment was long." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would enable me to accomplish debugging tasks more quickly"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would improve my debugging performance"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would increase my productivity"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would increase my debugging effectiveness"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would make it easier to debug the code"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find OCDbg useful"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "Learning to operate with OCDbg would be easy for me"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find it easy to get OCDbg to do what I want it to do, to track objects manipulations and locate the bug"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "My interaction with OCDbg would be clear and understandable"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "It would be easy for me to become skillful at using OCDbg"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "It is easy to remember how to debug a code using OCDbg"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find OCDbg easy to use"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "Assuming OCDbg would be available, I predict that I will use it in the future"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: " I would prefer OCDbg to the classic debugging system"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildPostTaskSurvey [

	| survey |
	survey := PhexSurvey new.
	survey title: 'Post-task survey'.


	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was easy." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was long." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).


	survey addQuestion: (self
			 singleChoiceQuestion: 'How long have you been interrupted?'
			 options:
				 #( 'Not interrupted' '1-2 minutes' 'up to 5 minutes'
				    'up to 10 minutes' 'more than 10 minutes' )).

	survey addQuestion: (self yesNoQuestion: 'Did you find the bug?').

	survey addQuestion:
		(self freeTextQuestion: 'If you found the bug, please describe it.').

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much the debugger helped to discover the bug?'
			 options:
			 #( 'Not at all' 'Slightly' 'Moderately' 'Normally' 'Extremely' )).


	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is enjoyable"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is efficient"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is intuitive"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is easy to use"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is asy to learn"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildTasks [

	|tasks task|
	tasks := OrderedCollection new.
	
	task := PhexTask new.
	task title: 'Ammolite'.
	task requiredAnswer: 'Explain why the level marker of the first student named Adèle is not displayed in any group lists.'.
	task requiresAnswer: true.
	task description: self task1Source.
	task contents: task description.
	task order: 1.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Tutorial'.
	task requiredAnswer: 'No answer to provide: click "ok" to continue'.
	task requiresAnswer: false.
	task description: self tutorialTaskSource.
	task contents: task description.
	task order: 2.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Warmup'.
	task requiredAnswer: 'Explain why the test is failing.'.
	task requiresAnswer: true.
	task description: self taskWarmupSource.
	task contents: task description.
	task order: 3.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Lights Out'.
	task requiredAnswer: 'Explain the bug and how you fixed it.'.
	task requiresAnswer: true.
	task description: self task2Source.
	task contents: task description.
	task order: 4.
	tasks add: task.
	
	^tasks
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment class >> developmentMode [

	^ DevelopmentMode
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment class >> developmentMode: anObject [

	DevelopmentMode := anObject
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment class >> initialize [

	DevelopmentMode := false
]

{ #category : #'building - sources' }
ObjectCentricDebuggingExperiment class >> task1Source [

^'# Program comprehension task

## The problem

Ammolite Magenta is a graphical application that can be launched via `AmmoliteMagenta class >> #run` (click on it).

* Run the application by executing this method (clic on the play button near the method name).

You should see the following application:

![Ammolite](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/ammolite.png)

The app is composed of a top left pane containing a list of student groups which, on selection, will be expanded in the top right pane.

Each student has a level marker attributed depending on how they perform during exams. When the level is significantly above average the marker used is "+", when lower, "-" is used, "nil" is used otherwise.

The bottom of the window there is a toolbar allowing to create groups of student with balanced levels.
After clicking the "generate" button you should see the bottom part updated as following:

![Ammolite groups](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/ammolite-groups.png)

However, **there is a bug**, the level marker of the first student named Adèle is not displayed in any group lists.

## Your task
* Understand why the level marker of this student is not displayed in any group lists.

To help you, you can inspect any student in the list by performing a right-click on it. This action will open an inspector on that student.
'
]

{ #category : #'building - sources' }
ObjectCentricDebuggingExperiment class >> task2Source [
^'# Debugging task

## The problem
LightsOutGame is a small graphical application that can be launched via `LightsOutGame class >> #open` (click on it).

* Run the application by executing this method (clic on the play button near the method name).

You should see the following application:

![Lights out game](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game.png)

In this game, each tile represents a light buld initially switched off. 
The unique action possible is to click on a tile/light, this will toggle the targeted light and its immediate neighbors as illustrated below.
To win the game, a player must turn on all the lights in a minimal amount of actions.

![Lights out game, toggled tiles](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game-toggles.png)

Unfortunately, there is a bug. As shown in the screenshot below, when the light bulb located on the 5th column and the 6th row is clicked, the light below is not switched on as expected. 

![Lights out game, bug](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game-bug.png)

In fact, no matter which adjacent tile is clicked, we can never see this light on. 

## Your task

* Understand why this light is never on.
* Fix the bug, that is, if the light can be switched on, the bug is fixed.

To help you, you can inspect any tile/light using the shortcut Ctrl + Shift + Option and by clicking on "inspect". 
This action will open an inspector on that tile.

**Beware:** this is a graphical application, and putting breakpoints in the display system (e.g., in the Morph class) might freeze your system.
'
]

{ #category : #'building - sources' }
ObjectCentricDebuggingExperiment class >> taskWarmupSource [
^'# Warmup task 1

This task is a warmup to practice the **halt on call** breakpoint.

The test `OCDPersonRegistryTest>>#testRegisterPersons` is failing. 
Try to understand why by using the **halt on call** breakpoint.

Remember that object-centric operations complements standard debugging tools.
The purpose of this task is not to restrict you to use only the **halt on call** breakpoint, but to use it when you feel necessary to complement standard debugging tools.

It is possible that you understand why the test fails without using the debugging tools.
If so, and for training purpose, try to use the object-centric tools to observe what you understood.

For example, from reading the source code you understand that a variable is set to nil into an object and that is the source of the problem.
Then, try to use the object-centric tools to observe the precise moment in the debugger where that variable is put to nil.
'
]

{ #category : #'building - sources' }
ObjectCentricDebuggingExperiment class >> tutorialTaskSource [
^'
# Tutorial
## Context: the OCDBox objects loop
In this example, we will use a class named `OCDBox`. It models a trivial object named box that holds objects. It has two instance variables, elements and name, and a few methods in its API. In particular, the method `OCDBox>>#addElement:`  (click on it) adds an object into the box.

We will use a test to practice object-centric breakpoints. In this test, we instantiate 100 boxes. We iterate over all these boxes to:

* add an object to each box,
 *  print the box on the Transcript.

Open the transcript (Browse > Transcript) then execute this test: `OCDBoxTest>>#testMultipleBoxes`.
The transcript shows you each box that is printed in the iteration loop. 
If you look at the code of the OCDBox class, you will see that:

* adding an element (`OCDBox>>#addElement:` )  to a box modifies its name,
 *  the printing method (`OCDBox>>#printString` ) uses the name to display the box in the Transcript.

## Tutorial: Breaking when an object receives a message 

### Use-cases

The typical use-case for this object-centric breakpoint is when you have many instances of the same class running in your program, while you are interested to debug a method for one specific object among these instances. You are interested to answer the following question: _When is this particular object executing this particular method during the execution?_ 

### Exercise 1

The `OCDBoxTest>>#testMultipleBoxes` test iterates over a hundred boxes objects, and to each object it sends the  `#addElement:` message. In this exercise, we select one box object among all the iterated boxes, and we install an object-centric breakpoint on the `OCDBox>>#addElement:` method of that object. Then, we proceed the test and the  the  `#addElement:` message is sent to each of the boxes. The execution only stops when the selected box executes the `OCDBox>>#addElement:` method.

**Step 1: getting to the object to debug**
Let us say that we want to debug the tenth box in the box collection.
The first step of object-centric debugging is to obtain this box object.
To do that, we first have to interrupt our execution and find the object in the debugger:
* Go to `OCDBoxTest>>#testMultipleBoxes` (click on it)
* Add a `self halt.` instruction just after the first `100 timesRepeat` loop
* Execute the test: the debugger opens on your halt
* Select the `Boxes` variable into the bottom inspector
* Select the object at index 10: you got the object to debug!

**Step 2: installing an object-centric breakpoint on our object**
In the meta inspection pane of the object you just selected, find the method  `OCDBox>>#addElement:`.
* Right-click on that method, and select _halt on call_ in the menu
* Proceed the execution in the debugger

The test continues and  iterates over the hundred boxes, and sends the addElement: message to each box object.
Only the box number 10 that you instrumented breaks when executing this method!

## Tutorial: Breaking when the state of a specific object is touched

### Use-cases

The typical use-case for this object-centric breakpoint is when you have many instances of the same class running in your program, while you are interested to know when the state of one specific object is modified. You are interested to answer the following question: _When is the state of this particular object modified during the execution?_

### Exercise 2

In this exercise, we reuse our test iterating over a hundred box objects. We select again a box among all the iterated boxes, but this time we want to stop when the `name` instance variable of that box is written to. To that end, we install an object-centric breakpoint on all write accesses to that variable in the selected object. Then, we proceed the test and the execution only breaks when the name instance variable of the selected box is modified.

**Step 1: getting to the object to debug**
Perform again the instructions from **Step 1** of **Exercise 1**.

**Step 1: getting to the object to debug**
In the raw pane of the inspector opened on your box object:
* Select the name instance variable in the table
* Right-click on that  item, and select `halt on write` in the menu
* Proceed the execution in the debugger

The test continues and iterates over the hundred boxes.
The execution breaks only when the box object we instrumented writes into its `name` instance variable. All other objects are not affected by the breakpoint.

## Removing and disabling breakpoints 
Breakpoints can be definitely removed, or temporary disabled.

**From the breakpoint navigator**
The breakpoint navigator gives us views and control over breakpoints installed in the system, such as visualizing where breakpoints are located in the source code and disabling/enabling them dynamically.

The navigator is accessible through Pharo main menu:

![breakpoint-nav](https://github.com/StevenCostiou/Pharo-VariableBreakpoint-Tutorial/raw/main/pictures/breakpoint-bnav-menu.png)

In this navigator, you see the following elements: 
1. The list of installed breakpoints in the system 
2. The list of methods affected by the selected breakpoint
3. The source code of the selected affected method, with the breakpoint locations highlighted

To enable or disable a breakpoint, just tick and untick the checkbox of the breakpoint.
Disabling a breakpoint does not uninstall it, but it stops having any effect.
Disabling and enabling breakpoints can be done dynamically at any point when your program is running.

To remove a breakpoint, just right click on the breakpoint line and select _remove_.

When you select a breakpoint, you see the list of methods affected by that breakpoint.
When you select one of these methods, you see the source code of that method with, highlighted, all the locations in the source code where (or when!) the breakpoint will interrupt the execution.

![breakpoint-nav-menu](https://github.com/StevenCostiou/Pharo-VariableBreakpoint-Tutorial/raw/main/pictures/breakpoint-navigator.png)

**From the inspector**
Removing a breakpoint from the inspector is straightforward.
Just inspect the object on which you installed a breakpoint. 
Go into the breakpoint pane: you can control breakpoints from there in the same manner as in the breakpoint navigator.

### Exercise 3
Do again exercise 1 and 2, but this time experiment breakpoint enabling/disabling and uninstalling through the breakpoint navigator and through the breakpoint pane when you inspect objects.

'
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> description [

	^ 'Object-Centric Debugging Experiment'
]

{ #category : #installation }
ObjectCentricDebuggingExperiment >> downloadAndInstallExternalTools [

	Metacello new
		baseline: 'BreakpointNavigator';
		repository: 'github://StevenCostiou/BreakpointNavigator:main';
		load.
		
	Metacello new
		baseline: 'AmmoliteMagenta';
		repository: 'github://StevenCostiou/AmmoliteMagenta:main';
		load.

	Metacello new
		baseline: 'LightsOutGame';
		repository: 'github://ValentinBourcier/LightsOutGame:master';
		load
]

{ #category : #installation }
ObjectCentricDebuggingExperiment >> downloadAndInstallSpy [

	Metacello new
		baseline: 'DebuggingSpy';
		repository: 'github://Pharo-XP-Tools/DebuggingSpy:master';
		load.
	Metacello new
		baseline: 'DSSpyEventRecorder';
		repository:'github://Pharo-XP-Tools/DebuggingSpy-EventRecorder:main';
		load
]

{ #category : #installation }
ObjectCentricDebuggingExperiment >> downloadAndInstallTasks [

	"Install the code related to the tasks. (Not the tasks descriptions presented in Phex)"
	|installer|
	Metacello new
		baseline: 'OCDEvalTasks';
		repository: 'github://Pharo-XP-Tools/OCDEval-Tasks';
		load.
	installer := (self findClass: #OCDTaskInstaller).
	installer installTasks.
	validator := installer buildValidator.
	"Note that this will remove code. If developing, manually set the experiment development flag to true (ObjectCentricDebuggingExperiment developmentMode: true"
	self class developmentMode ifFalse: [ (self findClass: #OCDTaskInstaller) removeFromSystem ]
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> experienceId [

	"The experienceId is also used as the root folder containing the tasks and results.
Therefore, use only filename-friendly characters.
"

	^ 'ocdbg-experiment'
]

{ #category : #installation }
ObjectCentricDebuggingExperiment >> findClass: aSymbol [

	^ self class environment at: aSymbol
]

{ #category : #'task management' }
ObjectCentricDebuggingExperiment >> finishTask: aTask [
	super finishTask: aTask.
	aTask order = 1 ifFalse:[^self].
	aTask order > 2 ifTrue:[^self].
	XPImageGeneration activateObjectCentricDebugging
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment >> generateParticipantUUID [

	^ participantUUID ifNil: [ 
		  | str |
		  str := WriteStream on: String new.
		  str << 'User-'.
		  str << UUID new asString.
		  str << DateAndTime now asNanoSeconds printString.
		  participantUUID := str contents ]
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> logger [

	^ logger ifNil: [ 
		  logger := (self findClass: #ExperimentLoggerDSSpy) on: self ]
]

{ #category : #'serialize/materialize' }
ObjectCentricDebuggingExperiment >> materializeTasks [

	| firstTask lastTask |
	super materializeTasks.

	"50% of the time, swap 1st and 2nd tasks"
	10 atRandom < 6 ifFalse: [ ^ self ].

	firstTask := self tasks first.
	lastTask := self tasks last.

	firstTask order: lastTask order.
	lastTask order: 1.
	
	self tasks reSort.
	
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> name [

	^ 'Object-Centric Debugging Experiment'
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment >> prepareSystemForExperiment [

	"Called when the experiment is selected and loaded in Phex. Do all experiment initialization logic here"

	"Why not adding everything as a baseline dependincy instead of doing this?
A: Control. Its difficult to selectively modify what happens between a baseline load and any of its dependencies. We do a manual installation instead, controlling the order, and other aspects such as changes logging."

	EpMonitor disableDuring: [ 
		self downloadAndInstallExternalTools.
		self downloadAndInstallSpy.
		self downloadAndInstallTasks.
		"remove the installation code (to cover tasks hints)"
		ObjectCentricDebuggingExperiment developmentMode ifFalse: [ 
			self class compile: 'downloadAndInstallTasks
		^self' ] ]
]

{ #category : #testing }
ObjectCentricDebuggingExperiment >> runTasksInOrder [

	^ true
]

{ #category : #'task management' }
ObjectCentricDebuggingExperiment >> startTask: aTask [
	super startTask: aTask.
	aTask order = 1 ifFalse:[^self].
	
	XPImageGeneration deactivateObjectCentricDebugging
]

{ #category : #actions }
ObjectCentricDebuggingExperiment >> validateTask: aTask [

	| str selector |
	str := WriteStream on: String new.
	str << 'test'.
	str << aTask title asCamelCase.
	str << 'Validity'.
	selector := str contents asSymbol.
	(validator respondsTo: selector) ifTrue: [ 
		logger logTaskSuccess: (validator perform: selector) forTask: aTask ]
]
