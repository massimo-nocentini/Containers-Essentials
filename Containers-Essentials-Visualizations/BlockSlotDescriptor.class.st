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

	inline := nil.

	self selectorHasBeenGiven
]

{ #category : #accessing }
BlockSlotDescriptor >> inline: aBoolean [

	inline := aBoolean
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inlineIfNil: aBlock [

	^ inline ifNil: aBlock
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
