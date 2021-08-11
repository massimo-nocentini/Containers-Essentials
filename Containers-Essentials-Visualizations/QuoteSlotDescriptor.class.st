Class {
	#name : #QuoteSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'descriptor',
		'shape',
		'quoteBlock'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
QuoteSlotDescriptor >> addDraggableInteractionOnShape: aShape [

	^ descriptor addDraggableInteractionOnShape: aShape
]

{ #category : #accessing }
QuoteSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	^ descriptor addHighlightInteractionOnShape: aShape
]

{ #category : #accessing }
QuoteSlotDescriptor >> addPopupInteractionOnShape: aShape [

	^ descriptor addPopupInteractionOnShape: aShape
]

{ #category : #accessing }
QuoteSlotDescriptor >> addQuotedShapeInVisit: aReceiver [

	^ aReceiver addQuotedShape: shape model: value
]

{ #category : #accessing }
QuoteSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
QuoteSlotDescriptor >> header [

	^ descriptor header
]

{ #category : #'as yet unclassified' }
QuoteSlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	^ descriptor inline: anObject level: anInteger default: aBoolean
]

{ #category : #testing }
QuoteSlotDescriptor >> isOneToManyFromVisit: aVisit [

	^ descriptor isOneToManyFromVisit: aVisit
]

{ #category : #initialization }
QuoteSlotDescriptor >> noHeader [

	descriptor noHeader
]

{ #category : #accessing }
QuoteSlotDescriptor >> on: anObject [

	| aShapeHolder |
	aShapeHolder := descriptor
		                on: anObject;
		                value.
		
	shape := quoteBlock value: aShapeHolder.

	self assert: (shape isKindOf: RSShape).

	value := Object new
]

{ #category : #accessing }
QuoteSlotDescriptor >> quoteBlock: aBlock [

	quoteBlock := aBlock
]

{ #category : #accessing }
QuoteSlotDescriptor >> selector [

	^ descriptor selector
]

{ #category : #accessing }
QuoteSlotDescriptor >> shapeWithPrototypeLabel: prototypeLabel [

	^ shape
]
