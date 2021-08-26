Class {
	#name : #CTBlockSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'selector',
		'inline',
		'header',
		'isOneToMany'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #visiting }
CTBlockSlotDescriptor >> addDraggableInteractionOnShape: aShape [

	aShape addInteraction: RSDraggable new
]

{ #category : #visiting }
CTBlockSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	aShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
CTBlockSlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	aShape addInteraction: RSHighlightable withLines
]

{ #category : #visiting }
CTBlockSlotDescriptor >> addPopupInteractionOnShape: aShape [

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
CTBlockSlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	"Nothing to do because I don't have a quoted shape."

	
]

{ #category : #accessing }
CTBlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #accessing }
CTBlockSlotDescriptor >> header: aBlock [

	header := aBlock
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	^ header value: anObject value: aShapeBuilder
]

{ #category : #initialization }
CTBlockSlotDescriptor >> headerWithAllSuperclasses [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeAllSuperclassesIndented: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #initialization }
CTBlockSlotDescriptor >> headerWithClass [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeClass: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #initialization }
CTBlockSlotDescriptor >> initialize [

	super initialize.

	self
		oneToOne;
		headerWithAllSuperclasses;
		inline: [ :anObject :level :aBoolean | aBoolean ];
		selectorHasBeenGiven
]

{ #category : #dispatching }
CTBlockSlotDescriptor >> inline: aController [

	aController inlineFromSlotDescriptor: self
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #dispatched }
CTBlockSlotDescriptor >> inlineBlockClosure: aBlock [

	inline := aBlock
]

{ #category : #dispatched }
CTBlockSlotDescriptor >> inlineBoolean: aBoolean [

	self inlineBlockClosure: [ :anObject :level :default | aBoolean ]
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> instVarNameHasBeenGiven [

	self blockClosure: [ :anObj :varName | anObj instVarNamed: varName ]
]

{ #category : #testing }
CTBlockSlotDescriptor >> isOneToManyFromVisit: aVisit [

	isOneToMany ifTrue: [ aVisit oneToMany: self value ]
]

{ #category : #initialization }
CTBlockSlotDescriptor >> noHeader [

	self header: [ :anObject :aShapeBuilder | RSBoundingShape nilShape ]
]

{ #category : #accessing }
CTBlockSlotDescriptor >> on: anObject [

	value := blockClosure cull: anObject cull: self selector
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> oneToOne [

	isOneToMany := false
]

{ #category : #accessing }
CTBlockSlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
CTBlockSlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> selectorHasBeenGiven [

	self blockClosure: [ :anObj :aSelector | anObj perform: aSelector ]
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> shape: aShapeBuilder [

	^ aShapeBuilder multilineLabel: self value
]

{ #category : #'as yet unclassified' }
CTBlockSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ aShapeBuilder label: anObject var: self selector
]
