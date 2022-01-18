Class {
	#name : #ObjectCentricDebuggingExperiment,
	#superclass : #DefaultGithubBasedExperiment,
	#classVars : [
		'DevelopmentMode'
	],
	#category : #'Experiments-OCDbg'
}

{ #category : #building }
ObjectCentricDebuggingExperiment class >> buildIntroSurvey [
	|textStream choices question survey |
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
	
	choices := #('yes' 'no').
	question := self singleChoiceQuestion: textStream contents options: choices.
	survey := PhexSurvey new.
	survey title: 'Experiment introduction and data policy.'.
	survey questions: { question }.
	^ survey
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

{ #category : #building }
ObjectCentricDebuggingExperiment class >> singleChoiceQuestion: text options: choices [

	^ PhexSingleChoiceQuestion new
		  title: text;
		  choices: choices;
		  yourself
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> description [

	^ 'Object-Centric Debugging Experiment'
]

{ #category : #installation }
ObjectCentricDebuggingExperiment >> downloadAndInstallSpy [

	Metacello new
		baseline: 'DebuggingSpy';
		repository: 'github://Pharo-XP-Tools/DebuggingSpy:master';
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

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> logger [

	^ logger ifNil: [ 
		  logger := (self findClass: #ExperimentLoggerDSSpy) new ]
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
		self downloadAndInstallSpy.
		self downloadAndInstallTasks.
		"remove the installation code (to cover tasks hints)"
		ObjectCentricDebuggingExperiment developmentMode ifFalse: [ 
			self class compile: 'downloadAndInstallTasks
		^self' ] ]
]
