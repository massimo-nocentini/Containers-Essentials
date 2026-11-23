"
I test the shapes that `CTDfsShapeBuilder` builds with Pango: their markup is drawn and not shown, and they leave the shared fonts of `PangoLogicalFontManager` as they are.
"
Class {
	#name : 'CTDfsShapeBuilderTest',
	#superclass : 'TestCase',
	#category : 'Containers-Essentials-Tests-Tests',
	#package : 'Containers-Essentials-Tests',
	#tag : 'Tests'
}

{ #category : 'private' }
CTDfsShapeBuilderTest >> commentHeight [
	"The height of a method comment, as CompiledMethod and the notebooks draw it"

	^ (PangoMarkupMicrodownVisitor new
		   visit: (Microdown parse: 'A comment.');
		   asRSPangoShapeUsingFont: PangoLogicalFontManager pangoSerif) height
]

{ #category : 'private' }
CTDfsShapeBuilderTest >> commentedClass: aString protocol: protocolName [
	"A class with the slot zork, whose accessor has the comment aString and is in protocolName"

	| class |
	class := Object newAnonymousSubclass.
	class addSlot: #zork asSlot.
	class
		compile: 'zork

	"' , (aString copyReplaceAll: '"' with: '""') , '"

	^ zork'
		classified: protocolName.

	^ class
]

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

{ #category : 'running' }
CTDfsShapeBuilderTest >> setUp [

	super setUp.

	"New fonts, as a test that changed the shared ones would hide the next one"
	PangoLogicalFontManager reset
]

{ #category : 'private' }
CTDfsShapeBuilderTest >> sharedFonts [

	^ #( sans serif monospace math ) collect: [ :each |
		  | font |
		  font := PangoLogicalFontManager logicalFontFor: each.
		  {
			  font.
			  font familyName.
			  font pointSize.
			  font emphasis } ]
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
CTDfsShapeBuilderTest >> testLabelVarKeepsTheSharedFonts [

	| fonts height |
	self deny: (Color >> #alpha) docString isEmpty.

	fonts := self sharedFonts.
	height := self commentHeight.

	CTDfsShapeBuilder new label: Color gray var: #alpha.

	self
		assert: self sharedFonts equals: fonts;
		assert: self commentHeight equals: height
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testLabelVarOfAnyCollectionKey [
	"The keys of a CTKeyedValuedOrderedCollection are not only strings"

	{
		('a<b&c' -> 'a<b&c').
		(#< -> '<').
		('a<b' asText -> 'a<b').
		(nil -> '').
		(5 -> '5').
		($& -> '&').
		(#( 1 2 ) -> '#(1 2)') } do: [ :each |
		| collection texts |
		collection := CTKeyedValuedOrderedCollection new
			              collection: { each key };
			              keyBlock: [ :key | key ];
			              valueBlock: [ :key | 42 ];
			              yourself.

		texts := (self pangoTextsOf: (self slotsShapeOf: collection))
			         collect: [ :text | self layoutTextOf: text ].

		self assert: (texts includes: each value) ]
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testLabelVarOfAnyComment [
	"The comment of the accessor is not drawn: an invalid raw markup in it, between double braces, does not matter"

	#( 'mustache {{a & b}}' '{{a < b}}' '{{<span>}}' '{{<nope>x</nope>}}' 'a < b & c' '{{<b>}}x{{</b>}}' ) do: [ :each |
		| object texts |
		object := (self commentedClass: each protocol: 'accessing') new.

		self deny: (object class >> #zork) docString isEmpty.

		{
			object.
			{ object } } do: [ :anObject |
			texts := (self pangoTextsOf: (self slotsShapeOf: anObject))
				         collect: [ :text | self layoutTextOf: text ].

			self assert: (texts includes: 'zork') ] ]
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
CTDfsShapeBuilderTest >> testMethodShapeKeepsTheSharedFonts [

	| fonts height |
	fonts := self sharedFonts.
	height := self commentHeight.

	self slotsShapeOf: Color >> #alpha.

	self
		assert: self sharedFonts equals: fonts;
		assert: self commentHeight equals: height
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testMethodShapeOfAnyProtocol [

	#( 'accessing' 'a<b&c' '<b>bold</b>' '"quoted" & ''quoted''' ) do: [ :each |
		| class texts |
		class := self commentedClass: 'A comment.' protocol: each.

		texts := (self pangoTextsOf: (self slotsShapeOf: class >> #zork))
			         collect: [ :text | self layoutTextOf: text ].

		self assert: (texts anySatisfy: [ :text |
				 text endsWith: ', protocol ' , each , '.' ]) ]
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testNotebookCommentKeepsTheSharedFonts [

	| fonts height notebook texts |
	fonts := self sharedFonts.
	height := self commentHeight.

	notebook := CTNotebookKeyedValuedOrderedCollection new.
	notebook
		codePresenter: (SpCodePresenter new
				 beForScripting;
				 text: '"A comment." 42';
				 yourself);
		value.

	texts := (self pangoTextsOf: (self slotsShapeOf: notebook)) collect: [
		         :each | self layoutTextOf: each ].

	self
		assert: (texts anySatisfy: [ :each | each includesSubstring: 'A comment.' ]);
		assert: self sharedFonts equals: fonts;
		assert: self commentHeight equals: height
]

{ #category : 'tests' }
CTDfsShapeBuilderTest >> testSlotsShapeKeepsTheSharedFonts [

	| fonts height |
	fonts := self sharedFonts.
	height := self commentHeight.

	self slotsShapeOf: Color gray.

	self
		assert: self sharedFonts equals: fonts;
		assert: self commentHeight equals: height
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
