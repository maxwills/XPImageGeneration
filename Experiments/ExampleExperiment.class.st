Class {
	#name : #ExampleExperiment,
	#superclass : #DefaultExperiment,
	#category : #Experiments
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
ExampleExperiment >> name [

	^ 'Example Experiment'
]
