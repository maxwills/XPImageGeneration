Class {
	#name : #AbstractExperimentLogger,
	#superclass : #Object,
	#category : #'XPImageGeneration-Logging'
}

{ #category : #'as yet unclassified' }
AbstractExperimentLogger >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractExperimentLogger >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractExperimentLogger >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractExperimentLogger >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	^ self subclassResponsibility
]
