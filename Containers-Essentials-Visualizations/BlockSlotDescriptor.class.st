Class {
	#name : #BlockSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'selector',
		'inline'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
BlockSlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	"Nothing to do because I don't have a quoted shape."

	
]

{ #category : #accessing }
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #initialization }
BlockSlotDescriptor >> initialize [

	super initialize.

	self
		inline: nil;
		selectorHasBeenGiven
]

{ #category : #accessing }
BlockSlotDescriptor >> inline: aController [

	inline := aController inlineBlock
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inlineQuoteAsShapeSlotsDfsTree [

	^ self
		  inline: true;
		  quote: #asShapeSlotsDfsTree
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> instVarNameHasBeenGiven [

	self blockClosure: [ :anObj :varName | anObj instVarNamed: varName ]
]

{ #category : #accessing }
BlockSlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
BlockSlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> selectorHasBeenGiven [

	self blockClosure: [ :anObj :aSelector | anObj perform: aSelector ]
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> shapeWithPrototypeLabel: prototypeLabel [

	^ value asString asMultilineLabelShape: prototypeLabel
]

{ #category : #accessing }
BlockSlotDescriptor >> value: anObject [

	^ value := blockClosure cull: anObject cull: self selector
]
