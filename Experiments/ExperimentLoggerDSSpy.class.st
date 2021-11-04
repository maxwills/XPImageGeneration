Class {
	#name : #ExperimentLoggerDSSpy,
	#superclass : #AbstractExperimentLogger,
	#category : #'Experiments-OCDbg'
}

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been finished.'
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	DSSpy logOnlyWhenTaskStarted: true.
	DSSpyInstrumenter instrumentSystem
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	DSSpy endTask: aTask
]

{ #category : #'as yet unclassified' }
ExperimentLoggerDSSpy >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	DSSpy startTask: aTask
]
