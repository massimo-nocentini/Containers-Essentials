Class {
	#name : #PropertySlotDescriptor,
	#superclass : #Object,
	#instVars : [
		'value',
		'valueLabel',
		'varLabel',
		'valueBox'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #accessing }
PropertySlotDescriptor >> addDraggableInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> addHighlightInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> addPopupInteractionOnShape: aShape [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PropertySlotDescriptor >> inline: anObject level: anInteger default: aBoolean [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> isOneToManyFromVisit: aVisit [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> noHeader [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> on: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> quote [

	^ self quote: [ :aShape | aShape ]
]

{ #category : #accessing }
PropertySlotDescriptor >> quote: aBlock [

	^ QuoteSlotDescriptor new
		  quoteBlock: aBlock;
		  descriptor: self;
		  yourself
]

{ #category : #accessing }
PropertySlotDescriptor >> selector [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> shape: aShapeBuilder [

	self subclassResponsibility
]

{ #category : #accessing }
PropertySlotDescriptor >> value [

	^ value
]

{ #category : #accessing }
PropertySlotDescriptor >> valueBox [

	^ valueBox
]

{ #category : #accessing }
PropertySlotDescriptor >> valueBox: anObject [

	valueBox := anObject
]

{ #category : #accessing }
PropertySlotDescriptor >> valueLabel [

	^ valueLabel
]

{ #category : #accessing }
PropertySlotDescriptor >> valueLabel: anObject [

	valueLabel := anObject
]

{ #category : #accessing }
PropertySlotDescriptor >> varLabel [

	^ varLabel
]

{ #category : #accessing }
PropertySlotDescriptor >> varLabel: anObject [

	varLabel := anObject
]

{ #category : #accessing }
PropertySlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	self subclassResponsibility
]