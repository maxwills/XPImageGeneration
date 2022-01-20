"
Logging entry point for PhexExperiments 
"
Class {
	#name : #ExperimentLogging,
	#superclass : #Object,
	#category : #'XPImageGeneration-Logging'
}

{ #category : #logger }
ExperimentLogging class >> setLoggerFor: anExperiment [

	"Sets the logger object for the experiment, and the  action handlers"

	| logger |
	logger := anExperiment logger.
	anExperiment whenTaskStartedDo: [ :xp :task | 
		logger taskStarted: task ].
	anExperiment whenTaskFinishedDo: [ :xp :task | 
		logger taskFinished: task.
		anExperiment isFinished ifTrue: [ 
			self flag: 'Does that work?'.
			logger experimentFinished: anExperiment ] ].
	anExperiment whenSurveyClosedDo: [ :survey | 
		logger surveyClosed: survey ]
]
