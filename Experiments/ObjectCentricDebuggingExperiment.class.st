Class {
	#name : #ObjectCentricDebuggingExperiment,
	#superclass : #DefaultGithubBasedExperiment,
	#category : #Experiments
}

{ #category : #accessing }
ObjectCentricDebuggingExperiment >> description [

	^ 'An example experience. Used to illustrate the usage of the framework'
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

{ #category : #'as yet unclassified' }
ObjectCentricDebuggingExperiment >> gitOwner [

	"Should return the owner of the git"

	"The repository should be your fork"

	^ self iceRepository origin owner
]

{ #category : #'as yet unclassified' }
ObjectCentricDebuggingExperiment >> gitRepositoryName [

	"Should return the name of the git repository, to create the url"

	"The repository should be your fork"

	^ self iceRepository origin projectName
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
