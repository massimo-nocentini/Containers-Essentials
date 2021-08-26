Class {
	#name : #CTQuoteSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'descriptor',
		'shape',
		'quoteBlock'
	],
	#category : #'Containers-Essentials-Inspector'
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

{ #category : #'as yet unclassified' }
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
CTQuoteSlotDescriptor >> on: anObject [

	shape := (descriptor on: anObject) value in: quoteBlock.

	self assert: (shape isKindOf: RSShape).

	value := Object new
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
