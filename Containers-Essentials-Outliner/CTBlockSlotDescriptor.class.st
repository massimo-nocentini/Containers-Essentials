"
I am a variant that uses a block to gather a reference to an object to be visited.
"
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
	#category : #'Containers-Essentials-Outliner'
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
CTBlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #accessing }
CTBlockSlotDescriptor >> header: aBlock [

	header := aBlock
]

{ #category : #accessing }
CTBlockSlotDescriptor >> header: anObject shapeBuilder: aShapeBuilder [

	^ header value: anObject value: aShapeBuilder
]

{ #category : #dispatched }
CTBlockSlotDescriptor >> headerWithAllSuperclasses [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeAllSuperclassesIndented: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #dispatched }
CTBlockSlotDescriptor >> headerWithClass [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeClass: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #initialization }
CTBlockSlotDescriptor >> initialize [

	super initialize.

	inline := [ :anObject :level :default | default ].

	self
		oneToOne;
		headerWithAllSuperclasses;
		blockClosure: [ :anObj :aSelector :aDfsWalker | 
			anObj perform: aSelector withEnoughArguments: { aDfsWalker } ]
]

{ #category : #dispatching }
CTBlockSlotDescriptor >> inline [

	inline := [ :anObject :level :default | true ]
]

{ #category : #accessing }
CTBlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #testing }
CTBlockSlotDescriptor >> isOneToManyFromVisit: aVisit [

	isOneToMany ifTrue: [ aVisit oneToMany: self value ]
]

{ #category : #initialization }
CTBlockSlotDescriptor >> noHeader [

	self header: [ :anObject :aShapeBuilder | 
		RSComposite new
			extent: 0 asPoint;
			yourself ]
]

{ #category : #dispatching }
CTBlockSlotDescriptor >> notInline [

	"To allow the DFS to proceed, regardless of the computed `default` flag."

	inline := [ :anObject :level :default | false ]
]

{ #category : #accessing }
CTBlockSlotDescriptor >> on: anObject walker: aDfsWalker [

	^ value := blockClosure
		           value: anObject
		           value: selector
		           value: aDfsWalker
]

{ #category : #accessing }
CTBlockSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #accessing }
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

{ #category : #accessing }
CTBlockSlotDescriptor >> shape: aShapeBuilder [

	^ aShapeBuilder multilineLabel: self value
]

{ #category : #accessing }
CTBlockSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ aShapeBuilder label: anObject var: self selector
]
