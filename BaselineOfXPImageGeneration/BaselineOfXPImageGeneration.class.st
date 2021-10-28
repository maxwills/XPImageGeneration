Class {
	#name : #BaselineOfXPImageGeneration,
	#superclass : #BaselineOf,
	#category : #BaselineOfXPImageGeneration
}

{ #category : #baselines }
BaselineOfXPImageGeneration >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec postLoadDoIt: #'postload:package:'.
		spec package: 'XPImageGeneration-Core'  ]
]

{ #category : #baselines }
BaselineOfXPImageGeneration >> postload: loader package: packageSpec [

	(self class environment at: #XPImageGeneration) generateImage
]
