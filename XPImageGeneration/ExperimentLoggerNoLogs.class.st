Class {
	#name : #ExperimentLoggerNoLogs,
	#superclass : #AbstractExperimentLogger,
	#category : #'XPImageGeneration-Logging'
}

{ #category : #'as yet unclassified' }
ExperimentLoggerNoLogs >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been finished.'
]

{ #category : #'as yet unclassified' }
ExperimentLoggerNoLogs >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been loaded.'
]

{ #category : #'as yet unclassified' }
ExperimentLoggerNoLogs >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	^ self inform:
		  'The task ' , aTask name , 'has been finished.'
]

{ #category : #'as yet unclassified' }
ExperimentLoggerNoLogs >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	^ self inform:
		  'The task ' , aTask name , 'has been started.'
]
