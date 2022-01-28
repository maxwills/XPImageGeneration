"
Defines a base behavior for any experiment that inherits from this class.
"
Class {
	#name : #DefaultGithubBasedExperiment,
	#superclass : #PhexExperiment,
	#instVars : [
		'logger'
	],
	#category : #'Experiments-Base'
}

{ #category : #adding }
DefaultGithubBasedExperiment class >> addTaskToExperimentRepository: aPhexTask [

	"Creates the file for the task in the filesystem and adds it to the repository.
  The repository needs to be commited and pushed in a posterior step.
"

	| exp tasksDir repoDummy taskFileName |
	exp := self currentExperiment.
	tasksDir := exp ensureTasksDefinitionFolder.
	repoDummy := self currentExperiment.
	repoDummy ensureUpstream.
	taskFileName := aPhexTask taskId , '.ptx'.
	tasksDir / taskFileName writeStreamDo: [ :ws | 
		ws nextPutAll: (STON toString: aPhexTask) ].
	repoDummy iceRepository addFileToIndex:
		repoDummy relativeTasksDirectory / taskFileName.
	repoDummy iceRepository workingCopy
		commitChanges: repoDummy iceRepository workingCopyDiff
		withMessage: taskFileName
		force: true.
	repoDummy iceRepository push
]

{ #category : #testing }
DefaultGithubBasedExperiment class >> isRunnableExperience [

	^ self ~= DefaultGithubBasedExperiment
]

{ #category : #api }
DefaultGithubBasedExperiment >> closeable [
	 ^false
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> ensureSurveysDefinitionFolder [

	| dir |
	dir := self surveysDirectory.
	dir ensureCreateDirectory.
	^ dir
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> ensureTasksDefinitionFolder [

	| dir |
	dir := self tasksDirectory.
	dir ensureCreateDirectory.
	^ dir
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> ensureUpstream [

	| remote |
	remote := self iceRepository remotes first.
	self iceRepository branch setUpstreamIfMissing: remote
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> iceRepository [

	| projectName |
	projectName := 'XPImageGeneration' "The project name of your fork of XPImageGeneration (in case of rename)".
	^ IceRepository repositories detect: [ :d | 
		  d location notNil and: [ 
			  d origin projectName = 'XPImageGeneration' ] ]
]

{ #category : #initialization }
DefaultGithubBasedExperiment >> logger [

	^ logger ifNil: [ logger := ExperimentLoggerNoLogs new ]
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> materializeTasks [

	super materializeTasks.
	self hasRunningTasks ifFalse: [ ^ self ].
	runningTasks size > 1 ifTrue: [ 
		UIManager default alert:
			'The task management system encountered a problem. Please inform the researcher managing the experiment' ]
]

{ #category : #initialization }
DefaultGithubBasedExperiment >> prepareSystemForExperiment [

	"Override this to write your experiment tasks initialization"

	"Called when the experiment is selected and loaded in Phex. Do all experiment initialization logic here"

	
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> relativeTasksDirectory [

	^ RelativePath new / 'tasksDefinition' / self experienceId
]

{ #category : #testing }
DefaultGithubBasedExperiment >> sequentialTasks [
	^true
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> surveysDirectory [

	^ self iceRepository location / 'surveysDefinition' / self experienceId
]

{ #category : #'serialize/materialize' }
DefaultGithubBasedExperiment >> tasksDirectory [

	^ self iceRepository location / 'tasksDefinition' / self experienceId
]

{ #category : #initialization }
DefaultGithubBasedExperiment >> tasksMaterializationFilter [

	"returns a filter that is applied when materializing tasks"

	"Override/change this this to make each user have a different set of tasks"

	^ [ :task | true "no filter" ]
]
