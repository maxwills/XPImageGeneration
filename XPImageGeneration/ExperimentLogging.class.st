Class {
	#name : #ExperimentLogging,
	#superclass : #Object,
	#classVars : [
		'currentLogger'
	],
	#category : #'XPImageGeneration-Logging'
}

{ #category : #'as yet unclassified' }
ExperimentLogging class >> currentLogger [

	^ currentLogger
]

{ #category : #'as yet unclassified' }
ExperimentLogging class >> setLoggerFor: anExperiment [

	"Sets the logger object for the experiment, and the  action handlers"

	currentLogger := anExperiment logger.
	anExperiment startingTaskAction: [ :xp :task | 
		currentLogger taskStarted: task ].
	anExperiment finishTaskAction: [ :xp :task | 
		currentLogger taskFinished: task.
		anExperiment isFinished ifTrue: [ 
			currentLogger experimentFinished: anExperiment ] ]
]
