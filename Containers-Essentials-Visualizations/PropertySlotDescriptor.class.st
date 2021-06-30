Class {
	#name : #PropertySlotDescriptor,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
PropertySlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PropertySlotDescriptor >> inlineIfNil: aBlock [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> quote [

	^ QuoteSlotDescriptor new
		  descriptor: self;
		  yourself
]

{ #category : #accessing }
PropertySlotDescriptor >> selector [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> shapeWithPrototypeLabel: prototypeLabel [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> value [

	^ value
]

{ #category : #accessing }
PropertySlotDescriptor >> value: anObject [

	self subclassResponsibility
]
