"
I am a logger that only display information when an experiment element is logged.
"
Class {
	#name : #ExperimentLoggerNoLogs,
	#superclass : #AbstractExperimentLogger,
	#category : #'XPImageGeneration-Logging'
}

{ #category : #logging }
ExperimentLoggerNoLogs >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been finished.'
]

{ #category : #logging }
ExperimentLoggerNoLogs >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been loaded.'
]

{ #category : #logging }
ExperimentLoggerNoLogs >> surveyClosed: aSurvey [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	^ self inform:
		  'The survey ' , aSurvey title , 'has been closed.'
]

{ #category : #logging }
ExperimentLoggerNoLogs >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	^ self inform:
		  'The task ' , aTask title , 'has been finished.'
]

{ #category : #logging }
ExperimentLoggerNoLogs >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	^ self inform:
		  'The task ' , aTask title , 'has been started.'
]
