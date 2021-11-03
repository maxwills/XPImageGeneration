Class {
	#name : #BaselineOfXPImageGeneration,
	#superclass : #BaselineOf,
	#category : #BaselineOfXPImageGeneration
}

{ #category : #baselines }
BaselineOfXPImageGeneration >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec postLoadDoIt: #postload:package:.
		spec package: 'XPImageGeneration' ]
]

{ #category : #baselines }
BaselineOfXPImageGeneration >> postload: loader package: packageSpec [

	UIManager default
		informUser: 'Generating experient image. Please wait...'
		during: [ 
		(self class environment at: #XPImageGeneration) generateImage ].
	(self class environment at: #XPMessageBox)
		showDialog: 'Experiment image generation completed.'
		withTitle: 'Finished!'
]
