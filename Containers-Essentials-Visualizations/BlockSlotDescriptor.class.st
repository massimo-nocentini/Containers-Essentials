Class {
	#name : #BlockSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'selector',
		'inline',
		'header',
		'isOneToMany'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
BlockSlotDescriptor >> addDraggableInteractionOnShape: aShape [

	aShape addInteraction: RSDraggable new
]

{ #category : #visiting }
BlockSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	aShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
BlockSlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	aShape addInteraction: RSHighlightable withLines
]

{ #category : #visiting }
BlockSlotDescriptor >> addPopupInteractionOnShape: aShape [

	aShape addInteraction: (RSPopup new text: [ :each | 
			 String streamContents: [ :aStream | 
				 aStream
					 nextPutAll: 'BFS level: ';
					 nextPutAll: aShape propertyDfsDepth asString;
					 cr;
					 nextPutAll: 'DFS timings: ';
					 nextPutAll: aShape propertyDfsTimings asString;
					 cr;
					 nextPutAll: 'SCC lowlink: ';
					 nextPutAll: aShape propertyDfsLowlink asString;
					 cr;
					 nextPutAll: 'SCC size: ';
					 nextPutAll: aShape propertyDfsSCC size asString ] ])
]

{ #category : #accessing }
BlockSlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	"Nothing to do because I don't have a quoted shape."

	
]

{ #category : #accessing }
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #accessing }
BlockSlotDescriptor >> header: aBlock [

	header := aBlock
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	^ header value: anObject value: aShapeBuilder
]

{ #category : #initialization }
BlockSlotDescriptor >> headerWithAllSuperclasses [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeAllSuperclassesIndented: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #initialization }
BlockSlotDescriptor >> headerWithClass [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeClass: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #initialization }
BlockSlotDescriptor >> initialize [

	super initialize.

	self
		oneToOne;
		headerWithAllSuperclasses;
		inline: [ :anObject :level :aBoolean | aBoolean ];
		selectorHasBeenGiven
]

{ #category : #dispatching }
BlockSlotDescriptor >> inline: aController [

	aController inlineFromSlotDescriptor: self
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #dispatched }
BlockSlotDescriptor >> inlineBlockClosure: aBlock [

	inline := aBlock
]

{ #category : #dispatched }
BlockSlotDescriptor >> inlineBoolean: aBoolean [

	self inlineBlockClosure: [ :anObject :level :default | aBoolean ]
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> instVarNameHasBeenGiven [

	self blockClosure: [ :anObj :varName | anObj instVarNamed: varName ]
]

{ #category : #testing }
BlockSlotDescriptor >> isOneToManyFromVisit: aVisit [

	isOneToMany ifTrue: [ aVisit oneToMany: self value ]
]

{ #category : #initialization }
BlockSlotDescriptor >> noHeader [

	self header: [ :anObject :aShapeBuilder | RSBoundingShape nilShape ]
]

{ #category : #accessing }
BlockSlotDescriptor >> on: anObject [

	value := blockClosure cull: anObject cull: self selector
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToOne [

	isOneToMany := false
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
BlockSlotDescriptor >> shape: aShapeBuilder [

	^ aShapeBuilder multilineLabel: self value
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ aShapeBuilder label: anObject var: self selector
]
