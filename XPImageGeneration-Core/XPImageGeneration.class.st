Class {
	#name : #XPImageGeneration,
	#superclass : #Object,
	#category : #'XPImageGeneration-Core'
}

{ #category : #actions }
XPImageGeneration class >> fixRichTextComposerErrorForClassNamed: className [

	| methodSource theClass |
	self flag: 'Hacky. Should be changed in the future'.
	theClass := self getClassNamed: className.
	methodSource := (theClass >> #asRenderedText) sourceCode.
	methodSource := methodSource
		                copyReplaceAll: 'PRRichTextComposer'
		                with: 'MicRichTextComposer'.
	theClass compile: methodSource
]

{ #category : #actions }
XPImageGeneration class >> fixRichTextComposerErrors [

	self fixRichTextComposerErrorForClassNamed: #ClyRichTextClassCommentEditorToolMorph.
	self fixRichTextComposerErrorForClassNamed: #ClyPackageRichTextCommentEditorToolMorph.
]

{ #category : #actions }
XPImageGeneration class >> generateImage [

	self loadBaselines.
	self install
]

{ #category : #'as yet unclassified' }
XPImageGeneration class >> getClassNamed: aString [

	^ self environment at: aString
]

{ #category : #actions }
XPImageGeneration class >> install [

	"Executed after the baseline. Fixes some bugs"

	self fixRichTextComposerErrors
]

{ #category : #'as yet unclassified' }
XPImageGeneration class >> loadBaselines [

	"Silent-ish loading"

	Metacello new
		baseline: 'Phex';
		repository: 'github://Pharo-XP-Tools/Phex:xp-tools';
		onWarning: [ :ex | ex resume ];
		load
]
