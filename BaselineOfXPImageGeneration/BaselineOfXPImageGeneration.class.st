Class {
	#name : #BaselineOfXPImageGeneration,
	#superclass : #BaselineOf,
	#category : #BaselineOfXPImageGeneration
}

{ #category : #baselines }
BaselineOfXPImageGeneration >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: #'MonticelloTonel-Core';
			package: #'MonticelloTonel-FileSystem'
			with: [ spec requires: #( 'MonticelloTonel-Core' ) ] ]
]
