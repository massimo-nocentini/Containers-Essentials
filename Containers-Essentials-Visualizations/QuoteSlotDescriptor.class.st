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
QuoteSlotDescriptor >> addQuotedShapeInVisit: aReceiver [

	^ aReceiver addQuotedShape: shape model: value
]

{ #category : #accessing }
QuoteSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #'as yet unclassified' }
QuoteSlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	^ descriptor inline: anObject level: anInteger default: aBoolean
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

{ #category : #accessing }
QuoteSlotDescriptor >> value: anObject [

	| aShapeHolder |
	aShapeHolder := descriptor value: anObject.
	shape := quoteBlock value: aShapeHolder.

	self assert: (shape isKindOf: RSShape).

	^ value := Object new
]
