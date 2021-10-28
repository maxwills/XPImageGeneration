"
Defines a base behavior for any experiment that inherits from this class.
"
Class {
	#name : #DefaultExperiment,
	#superclass : #PhexExperiment,
	#category : #Experiments
}

{ #category : #accessing }
DefaultExperiment class >> currentExperiment [

	"Called by the experiment framework when the participant selects an experience from the list"

	"Returns an instance of the Experiment"

	^ self new
]

{ #category : #testing }
DefaultExperiment class >> isRunnableExperience [

	^ self ~= DefaultExperiment
]

{ #category : #api }
DefaultExperiment >> closeable [
	 ^false
]

{ #category : #'serialize/materialize' }
DefaultExperiment >> materializeTasks [

	super materializeTasks.
	self hasRunningTasks ifFalse: [ ^ self ].
	runningTasks size > 1 ifTrue: [ 
		UIManager default alert:
			'The task management system encountered a problem. Please inform the researcher managing the experiment' ]
]

{ #category : #testing }
DefaultExperiment >> sequentialTasks [
	^true
]
