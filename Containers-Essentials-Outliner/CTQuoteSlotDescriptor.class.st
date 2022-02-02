"
I am a variant that stops the visit and provides an already built shape to be referenced in a slot.
"
Class {
	#name : #CTQuoteSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'descriptor',
		'shape',
		'quoteBlock'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTQuoteSlotDescriptor >> addDraggableInteractionOnShape: aShape [

	^ descriptor addDraggableInteractionOnShape: aShape
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	^ descriptor addHighlightInteractionOnShape: aShape
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	^ descriptor addHighlightWithLinesInteractionOnShape: aShape
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> addPopupInteractionOnShape: aShape [

	^ descriptor addPopupInteractionOnShape: aShape
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> addQuotedShapeInVisit: aReceiver [

	^ aReceiver addQuotedShape: shape model: value
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #initialization }
CTQuoteSlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	^ descriptor header: anObject shapeBuilder: aShapeBuilder
]

{ #category : #dispatched }
CTQuoteSlotDescriptor >> headerWithClass [

	descriptor headerWithClass
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	^ descriptor inline: anObject level: anInteger default: aBoolean
]

{ #category : #testing }
CTQuoteSlotDescriptor >> isOneToManyFromVisit: aVisit [

	^ descriptor isOneToManyFromVisit: aVisit
]

{ #category : #initialization }
CTQuoteSlotDescriptor >> noHeader [

	descriptor noHeader
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> on: anObject walker: aDfsWalker [

	descriptor on: anObject walker: aDfsWalker.

	shape := descriptor value in: [ :innerObject | 
		         quoteBlock value: innerObject value: aDfsWalker ].

	self assert: (shape isKindOf: RSShape).

	value := Object new.
"
	aDfsWalker addQuotedShape: shape model: value"
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> quoteBlock: aBlock [

	quoteBlock := aBlock
]

{ #category : #accessing }
CTQuoteSlotDescriptor >> selector [

	^ descriptor selector
]

{ #category : #testing }
CTQuoteSlotDescriptor >> shape: aShapeBuilder [

	^ shape
]

{ #category : #initialization }
CTQuoteSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ descriptor varLabelShapeOf: anObject shapeBuilder: aShapeBuilder
]
