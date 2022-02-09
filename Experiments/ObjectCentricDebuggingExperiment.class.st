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
			 'If you would be informed about results of this work, please add your e-mail').

	survey addQuestion: (self freeTextQuestion:
			 'If you would participate to a more detailed interview, please add your e-mail').

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
			 options: #( 'Bachelor or equivalent' 'Master or equivalent'
				    'PhD or higher academic title' 'None of the above' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'What is you current job position? (CS = Computer Science)'
			 options: #( 'Student' 'Software developer or engineer'
				    'Researcher' 'CS Engineer but not in software'
				    'Other CS position' 'Other (not CS)' )).

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

	10 atRandom < 6 ifTrue: [ 
		| firstTask lastTask |
		firstTask := tasks removeFirst.
		lastTask := tasks removeLast.
		firstTask order: lastTask order.
		lastTask order: 1.
		tasks addFirst: lastTask.
		tasks addLast: firstTask ].
	
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
	The data analysis is under the responsibility of Alberto Bachelli, University of Zurich, contact: '.
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
	task title: 'Task 1'.
	task requiredAnswer: 'You must provide an answer'.
	task requiresAnswer: true.
	task description: self task1Source.
	task contents: task description.
	task order: 1.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Tutorial'.
	task requiredAnswer: 'You have no answer to provide'.
	task requiresAnswer: false.
	task description: self tutorialTaskSource.
	task contents: task description.
	task order: 2.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Task 2'.
	task requiredAnswer: 'You must provide an answer'.
	task requiresAnswer: true.
	task description: self task2Source.
	task contents: task description.
	task order: 3.
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
^'# Task 1

A `MetaLink` is an object that annotates the Abstract Syntax Tree of a program. When the program executes, the annotated AST nodes trigger its metalinks which executes additional behavior.

All-in-all, you can consider that an AST node corresponds to a particular expression in your source code. For example, if you install a metalink object on an instance variable of a class, the metalink will annotate all expressions referring to that instance variable in the source code of this class’ methods. The metalink object holds a set of AST nodes corresponding to these expressions, so that it knows where it is installed in the source code. 

During the metalink installation process, each time a metalink object annotates an AST node (_i.e._, an expression in the source code), this AST node is added to the set of nodes held by the metalink object.

## The problem
In this task, we provide a test method  (`MetalinkStrangeNodeTest>>#testCollectionContents`, click on it) that installs a metalink object on an instance variable `instVar` of a class `ReflectivityExamples2`. 

This instance variable is referenced in 4 expressions in the source code of the `ReflectivityExamples2` class. Therefore, the test expects that after installation, the metalink’s set will hold 4 AST nodes, one for each source code expression referring to instVar. 

However, the test fails due to the metalink holding an incorrect number of nodes after installation: there is an extra node in the nodes set of the metalink. 

We consider that the metalink installation process is correct: it is the test that is wrong.

## Your task
Your task is to understand why the test is not correctly testing the metalink installation process:.
You have to: 
* Understand the error in the test
* Fix the error to make the test pass
* Explain why the number of nodes is incorrect, i.e., the reason why there is an extra node (where in the source code, and why). 

To help you, we stored the set of nodes held by the metalink in an instance variable in the test. This variable is named nodes

This set is **the same as the one in the metalink object**: the AST nodes in this set are the nodes on which the metalink is installed.

**Beware:** Sets are used everywhere in the system. Attempting to put a breakpoint in a method of the `Set` class might freeze your image.
'
]

{ #category : #'building - sources' }
ObjectCentricDebuggingExperiment class >> task2Source [
^'# Task 2

## The problem
AtomApp is a small graphical application that can be launched via `AtomApp class >> #run` (click on it).

* Run the application by executing this method (clic on the play button near the method name).

You should see the following application:

![AtomApp](https://raw.githubusercontent.com/Pharo-XP-Tools/XPImageGeneration/exp-ocd/tasksDefinition/ocdbg-experiment/atoms.png)

The app is composed of colored squares named atoms. 
Each time the mouse moves over a square, the color of the square changes.

* Move your mouse over the squares, and see the behavior.

The atoms squares are instances of a class `AtomMorph`.  
In this class, we redefined the method `AtomMorph>>#handleMouseMove:` so that each time the mouse moves over an atom, we request a color change for that atom.

The color of an atom is changed by modifying it’s instance variable `color` and putting a new color object in that variable. This instance variable is modified, in particular, when sending the `Morph>>#color:` message to atoms objects. 

However, as you will notice in the provided application and in the animated image above, one of the atoms never changes color when the mouse moves over it. Actually, most atoms do change their color, but it seems that green atoms do not. 
* Move your mouse over non-green  squares and over green squares.  Repeat it many times and observe the behavior.

**This is a bug:** all atoms should change color when you move the mouse above them.

## Your task
* Understand why some green squares do not have the same behavior as other squares
* Fix the bug, that is, if all atoms change color when moving the mouse over them, then you’ve fixed the bug.

To help you, you can inspect any atom by performing a right-click on it. This action will open an inspector on that atom.

**Beware:** this is a graphical application, and putting breakpoints in the display system (e.g., in the Morph class) might freeze your system.
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

	Metacello new
		baseline: 'OCDEvalTasks';
		repository: 'github://Pharo-XP-Tools/OCDEval-Tasks:updated-task1';
		load.
	(self findClass: #OCDTaskInstaller) installTasks.
	"Note that this will remove code. If developing, manually set the experiment development flag to true (ObjectCentricDebuggingExperiment developmentMode: true"
	ObjectCentricDebuggingExperiment developmentMode ifFalse: [ 
		(self findClass: #OCDTaskInstaller) removeTaskInstallerSilently ]
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
	aTask == tasks first ifFalse:[^self].
	
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

{ #category : #'task management' }
ObjectCentricDebuggingExperiment >> startTask: aTask [
	super startTask: aTask.
	aTask == tasks first ifFalse:[^self].
	
	XPImageGeneration deactivateObjectCentricDebugging
]
