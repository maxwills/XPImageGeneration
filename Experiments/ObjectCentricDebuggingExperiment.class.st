Class {
	#name : #ObjectCentricDebuggingExperiment,
	#superclass : #DefaultGithubBasedExperiment,
	#category : #'Experiments-OCDbg'
}

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> description [

	^ 'Object-Centric Debugging Experiment'
]

{ #category : #'as yet unclassified' }
ObjectCentricDebuggingExperiment >> downloadAndInstallTasks [

	Metacello new
		baseline: 'OCDEvalTasks';
		repository: 'github://Pharo-XP-Tools/OCDEval-Tasks:updated-task1';
		load.
	(self class environment at: #OCDTaskInstaller) installTasks.
	(self class environment at: #OCDTaskInstaller)
		removeTaskInstallerSilently
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> experienceId [

	"The experienceId is also used as the root folder containing the tasks and results.
Therefore, use only filename-friendly characters.
"

	^ 'ocdbg-experiment'
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> logger [

	^ logger ifNil: [ logger := ExperimentLoggerDSSpy new ]
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> name [

	^ 'Object-Centric Debugging Experiment'
]

{ #category : #initialization }
ObjectCentricDebuggingExperiment >> prepareSystemForExperiment [

	EpMonitor disableDuring: [ 
		self downloadAndInstallTasks.
		self class compile: 'downloadAndInstallTasks
		^self' ]
]
