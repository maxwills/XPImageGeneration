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
	self flag: 'It is doubtful that, when tasks, surveys and experiments start and finish, the only action is logging. If that is not true, then this code should not be there but in the experiment definition.'.
	anExperiment whenTaskStartedDo: [ :xp :task | 
		logger taskStarted: task ].
	anExperiment whenTaskFinishedDo: [ :xp :task | 
		logger taskFinished: task ].
	anExperiment whenFinishedDo: [ 
		logger experimentFinished: anExperiment ].
	anExperiment whenSurveyClosedDo: [ :survey | 
		logger surveyClosed: survey ]
]
