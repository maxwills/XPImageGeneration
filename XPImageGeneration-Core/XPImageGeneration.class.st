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

{ #category : #'as yet unclassified' }
XPImageGeneration class >> getClassNamed: aString [

	^ self environment at: aString
]

{ #category : #actions }
XPImageGeneration class >> install [

	"Executed after the baseline. Fixes some bugs"

	self fixRichTextComposerErrors
]
