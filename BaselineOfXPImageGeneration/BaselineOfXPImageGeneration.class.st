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
			baseline: 'XPImageGeneration'
			with: [ spec repository: 'github://maxwills/Phex:main' ].
		"spec
			baseline: 'DebuggingSpy'
			with: [ 
			spec repository: 'github://StevenCostiou/DebuggingSpy:master' ]."

		spec package: 'XPImageGeneration' ]
]
