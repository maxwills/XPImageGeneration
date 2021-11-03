Class {
	#name : #XPMessageBox,
	#superclass : #MessageDialogWindow,
	#instVars : [
		'entryText'
	],
	#category : #'XPImageGeneration-UI'
}

{ #category : #'as yet unclassified' }
XPMessageBox class >> showDialog: text withTitle: title [

	| dialog width linesCount |
	linesCount := 0.
	width := 0.
	text linesDo: [ :l | 
		linesCount := linesCount + 1.
		width := width max: (self theme textFont widthOfStringOrText: l) ].
	dialog := self new entryText: text.
	dialog title: title.
	dialog open.
	dialog textMorph
		minWidth: 20;
		minHeight: 20.
	dialog width: (width + 120 min: Display width - 50).
	dialog height: 100 + (linesCount * 19).
	dialog position: 25 @ 25
]

{ #category : #accessing }
XPMessageBox >> entryText [
	"Answer the value of entryText"

	^ entryText
]

{ #category : #accessing }
XPMessageBox >> entryText: anObject [
	"Set the value of entryText"

	entryText := anObject.
	self changed: #entryText
]

{ #category : #testing }
XPMessageBox >> isResizeable [
	"Answer whether we are not we can be resized."

	^true
]

{ #category : #building }
XPMessageBox >> newContentMorph [
	"Answer a new content morph."

	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	^self newGroupboxFor: (
		(self newRow: {self iconMorph. self textMorph})
			cellPositioning: #top;
			vResizing: #spaceFill)
]

{ #category : #building }
XPMessageBox >> newTextMorph [
	"Answer a new text editor morph."

	|tm|
	tm := (self
		newTextEditorFor: self
		getText: #entryText
		setText: #entryText:
		getEnabled: nil)
			beForPlainText;
			minWidth: 30;
			minHeight: 30;
			beReadOnly.
	^tm
]

{ #category : #accessing }
XPMessageBox >> text: aStringOrText [
	"Set the text."
	
	|t|
	t := aStringOrText isString
		ifTrue: [aStringOrText asText addAttribute: (TextFontReference toFont: self textFont); yourself]
		ifFalse: [aStringOrText].
	self entryText: t
]
