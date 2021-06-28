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
QuoteSlotDescriptor >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #'as yet unclassified' }
QuoteSlotDescriptor >> ifQuotation: qBlock ifNotQuotation: nqBlock [

	^ qBlock value: value value: shape
]

{ #category : #accessing }
QuoteSlotDescriptor >> value: anObject [

	shape := descriptor value: anObject.

	self assert: (shape isKindOf: RSShape).

	^ value := Object new
]
