Class {
	#name : #ExampleExperiment,
	#superclass : #DefaultGithubBasedExperiment,
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

{ #category : #'as yet unclassified' }
ExampleExperiment >> gitOwner [

	"Should return the owner of the git"

	"The repository should be your fork"

	^ self iceRepository origin owner
]

{ #category : #'as yet unclassified' }
ExampleExperiment >> gitRepositoryName [

	"Should return the name of the git repository, to create the url"

	"The repository should be your fork"

	^ self iceRepository origin projectName
]

{ #category : #accessing }
ExampleExperiment >> name [

	^ 'Example Experiment'
]
