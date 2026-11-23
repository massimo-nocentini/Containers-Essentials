"
I test the shapes that `CTDfsShapeBuilder` builds with Pango: their markup is drawn and not shown.
"
Class {
	#name : 'CTDfsShapeBuilderTest',
	#superclass : 'TestCase',
	#category : 'Containers-Essentials-Tests-Tests',
	#package : 'Containers-Essentials-Tests',
	#tag : 'Tests'
}

{ #category : 'private' }
CTDfsShapeBuilderTest >> layoutTextOf: aPangoText [
	"The text that Pango lays out, without the tags of a markup"

	^ PangoLayout measuringDo: [ :layout |
		  aPangoText configureLayout: layout.
		  layout text ]
]

{ #category : 'private' }
CTDfsShapeBuilderTest >> pangoTextsOf: aShape [

	^ Array streamContents: [ :aStream |
		  self pangoTextsOf: aShape on: aStream ]
]

{ #category : 'private' }
CTDfsShapeBuilderTest >> pangoTextsOf: aShape on: aStream [

	(aShape isKindOf: RSPangoText) ifTrue: [ aStream nextPut: aShape ].

	(aShape isKindOf: RSComposite) ifTrue: [
		aShape children do: [ :each | self pangoTextsOf: each on: aStream ] ]
]

{ #category : 'private' }
CTDfsShapeBuilderTest >> slotsShapeOf: anObject [

	^ anObject asShapeSlotsDfsTree: (CTDfsWalker new
			   slotDescriptorsVisitor: CTSlotDescriptorsVisitor new;
			   yourself)
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testLabelVarIsEscaped [

	#( #< #'->' #& 'a<b&c' '<b>bold</b>' '' ) do: [ :each |
		| shape |
		shape := CTDfsShapeBuilder new label: Object new var: each.

		self assert: (self layoutTextOf: shape) equals: each asString ]
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testLabelVarIsVisibleInEveryTheme [
	"The box below is white in every theme, the selectors of a dark theme too"

	| shape |
	shape := CTDfsShapeBuilder new label: Color gray var: #alpha.

	self
		assert: shape color equals: Color black;
		deny: (shape text includesSubstring: 'foreground')
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testLabelVarShowsNoTags [

	| shape |
	shape := CTDfsShapeBuilder new label: Color gray var: #alpha.

	self
		assert: shape isMarkup;
		assert: (self layoutTextOf: shape) equals: 'alpha'
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testSlotsShapeShowsNoTags [

	| texts |
	texts := (self pangoTextsOf: (self slotsShapeOf: Color gray)) collect: [
		         :each | self layoutTextOf: each ].

	self
		assert: (texts includes: 'alpha');
		assert: (texts noneSatisfy: [ :each | each includesSubstring: '<span' ])
]
