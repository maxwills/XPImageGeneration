Class {
	#name : #ExperimentLoggerDSSpy,
	#superclass : #AbstractExperimentLogger,
	#category : #'Experiments-OCDbg'
}

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> dsSpyClass [

	"Why like this? DDSpy is installed whe the experiment starts. When developing the experiment (without starting the experiment), the class is not loaded. This prevent some warnings."
	
	"Can be probalby properly fixed by adding DSSpy as a dependency of the baseline"

	^ self class environment at: #DDSpy
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> dsSpyInstrumenterClass [

	^ self class environment at: #DDSpyInstrumenter
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been finished.'
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	| dsSpyClass dsSpyInstrumentationClass |
	dsSpyClass := self dsSpyClass.
	dsSpyInstrumentationClass := self dsSpyInstrumenterClass.
	dsSpyClass logOnlyWhenTaskStarted: true.
	dsSpyInstrumentationClass DSSpyInstrumenter instrumentSystem
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	| dsSpyClass |
	dsSpyClass := self dsSpyClass.
	dsSpyClass endTask: aTask
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	| dsSpyClass |
	dsSpyClass := self dsSpyClass.
	dsSpyClass startTask: aTask
]
