"
I am a variant that uses a block to gather a reference to an object to be visited.
"
Class {
	#name : #CTBaseSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'selector',
		'inline',
		'header',
		'isOneToMany',
		'enablePredicate',
		'postpone'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #visiting }
CTBaseSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	aShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
CTBaseSlotDescriptor >> addHighlightWithLinesInteractionOnShape: aShape [

	aShape addInteraction: RSHighlightable withLines
]

{ #category : #visiting }
CTBaseSlotDescriptor >> addPopupInteractionOnShape: aShape [

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
CTBaseSlotDescriptor >> enablePredicate: aBlock [

	enablePredicate := aBlock
]

{ #category : #accessing }
CTBaseSlotDescriptor >> enabled [

	^ enablePredicate value
]

{ #category : #accessing }
CTBaseSlotDescriptor >> header: aBlock [

	header := aBlock
]

{ #category : #accessing }
CTBaseSlotDescriptor >> header: anObject walker: walker [

	^ header value: anObject value: walker shapeBuilder
]

{ #category : #dispatched }
CTBaseSlotDescriptor >> headerWithAllSuperclasses [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeAllSuperclassesIndented: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #dispatched }
CTBaseSlotDescriptor >> headerWithClass [

	self header: [ :anObject :aShapeBuilder | 
		anObject class asShapeClass: [ :each | 
			aShapeBuilder labelForClass: each ] ]
]

{ #category : #delegating }
CTBaseSlotDescriptor >> ifHasFollowers: block walker: walker [

	^ nil
]

{ #category : #initialization }
CTBaseSlotDescriptor >> initialize [

	super initialize.

	inline := [ :anObject :level :default | default ].

	self
		oneToOne;
		headerWithAllSuperclasses;
		enablePredicate: [ true ];
		postpone: false
]

{ #category : #dispatching }
CTBaseSlotDescriptor >> inline [

	inline := [ :anObject :level :default | true ]
]

{ #category : #accessing }
CTBaseSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #testing }
CTBaseSlotDescriptor >> isOneToMany: anObject walker: aDfsWalker [

	isOneToMany ifTrue: [ aDfsWalker oneToMany: anObject ]
]

{ #category : #initialization }
CTBaseSlotDescriptor >> noHeader [

	self header: [ :anObject :aShapeBuilder | 
		RSComposite new
			extent: 0 asPoint;
			yourself ]
]

{ #category : #dispatching }
CTBaseSlotDescriptor >> noInline [

	inline := [ :anObject :level :default | false ]
]

{ #category : #accessing }
CTBaseSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #accessing }
CTBaseSlotDescriptor >> oneToOne [

	isOneToMany := false
]

{ #category : #accessing }
CTBaseSlotDescriptor >> postpone: aBoolean [

	postpone := postpone
]

{ #category : #accessing }
CTBaseSlotDescriptor >> postponed [

	^ postpone
]

{ #category : #accessing }
CTBaseSlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
CTBaseSlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
CTBaseSlotDescriptor >> shape: anObject walker: aDfsWalker [

	^ aDfsWalker defaultShapeOf: anObject
]

{ #category : #accessing }
CTBaseSlotDescriptor >> varLabelShapeOf: anObject shapeBuilder: aShapeBuilder [

	^ aShapeBuilder label: anObject var: self selector
]
