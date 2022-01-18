Class {
	#name : #ExampleExperiment,
	#superclass : #DefaultGithubBasedExperiment,
	#category : #'Experiments-Base'
}

{ #category : #accessing }
ExampleExperiment >> description [

	^ 'An example experience. Used to illustrate the usage of the framework'
]

{ #category : #accessing }
ExampleExperiment >> experienceId [

	"The experienceId is also used as the root folder containing the tasks and results.
Therefore, use only filename-friendly characters.
"

	^ 'example-experiment-id'
]


{ #category : #accessing }
ExampleExperiment >> logger [

	^ logger ifNil: [ logger := ExperimentLoggerNoLogs new ]
]

{ #category : #accessing }
ExampleExperiment >> name [

	^ 'Example Experiment'
]

{ #category : #initialization }
ExampleExperiment >> prepareSystemForExperiment [

	EpMonitor disableDuring: [
		 "Download baselines, compile code, add or remove classes here (in this block). With the EpMonitor disabled, changes
		will not appear in the Epicea Code Changes viewer"
		 ]
]
