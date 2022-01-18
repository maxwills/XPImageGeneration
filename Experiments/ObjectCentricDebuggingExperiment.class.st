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
ObjectCentricDebuggingExperiment >> downloadAndInstallSpy [

	Metacello new
		baseline: 'DebuggingSpy';
		repository: 'github://Pharo-XP-Tools/DebuggingSpy:master';
		load
]

{ #category : #'as yet unclassified' }
ObjectCentricDebuggingExperiment >> downloadAndInstallTasks [

	Metacello new
		baseline: 'OCDEvalTasks';
		repository: 'github://Pharo-XP-Tools/OCDEval-Tasks:updated-task1';
		load.
	(self findClass: #OCDTaskInstaller) installTasks.
	(self findClass: #OCDTaskInstaller) removeTaskInstallerSilently
]

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> experienceId [

	"The experienceId is also used as the root folder containing the tasks and results.
Therefore, use only filename-friendly characters.
"

	^ 'ocdbg-experiment'
]

{ #category : #'as yet unclassified' }
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

	EpMonitor disableDuring: [ 
		self downloadAndInstallSpy.
		self downloadAndInstallTasks.
		self class compile: 'downloadAndInstallTasks
		^self' ]
]
