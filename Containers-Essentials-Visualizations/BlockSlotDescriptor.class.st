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
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #accessing }
BlockSlotDescriptor >> doesDescribeAnImmediateObject [

	^ inline
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> ifQuotation: qBlock ifNotQuotation: nqBlock [

	^ nqBlock value: value
]

{ #category : #initialization }
BlockSlotDescriptor >> initialize [

	super initialize.

	inline := false.

	self selectorHasBeenGiven
]

{ #category : #accessing }
BlockSlotDescriptor >> inline [

	inline := true
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

{ #category : #accessing }
BlockSlotDescriptor >> value: anObject [

	^ value := blockClosure cull: anObject cull: self selector
]
