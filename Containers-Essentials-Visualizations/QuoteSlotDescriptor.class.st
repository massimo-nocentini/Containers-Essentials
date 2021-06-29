Class {
	#name : #QuoteSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'descriptor',
		'shape'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
QuoteSlotDescriptor >> addQuotedShapeInDictionary: quotedShapes [

	^ quotedShapes at: value put: shape
]

{ #category : #accessing }
QuoteSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #'as yet unclassified' }
QuoteSlotDescriptor >> inlineIfNil: aBlock [

	^ descriptor inlineIfNil: aBlock
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

	shape := descriptor value: anObject.

	self assert: (shape isKindOf: RSShape).

	^ value := Object new
]
