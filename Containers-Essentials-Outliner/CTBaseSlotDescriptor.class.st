"
I am a variant that uses a block to gather a reference to an object to be visited.
"
Class {
	#name : #CTBaseSlotDescriptor,
	#superclass : #CTPropertySlotDescriptor,
	#instVars : [
		'selector',
		'header',
		'isOneToMany',
		'enablePredicate',
		'inlinePredicate'
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

{ #category : #dispatching }
CTBaseSlotDescriptor >> dispatchPostponed: child data: data walker: walker otherwise: oBlock [

	^ oBlock value
]

{ #category : #accessing }
CTBaseSlotDescriptor >> enablePredicate: aBlock [

	enablePredicate := aBlock
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

	self
		oneToOne;
		headerWithAllSuperclasses;
		inlinePredicate: [ :level :default | default ];
		enablePredicate: [ :level | true ];
		postpone: false
]

{ #category : #dispatching }
CTBaseSlotDescriptor >> inline [

	self inlinePredicate: [ :level :default | true ]
]

{ #category : #accessing }
CTBaseSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inlinePredicate value: level value: aBoolean
]

{ #category : #accessing }
CTBaseSlotDescriptor >> inlinePredicate: anObject [

	inlinePredicate := anObject
]

{ #category : #testing }
CTBaseSlotDescriptor >> isEnabledAtLevel: l [

	^ enablePredicate value: l
]

{ #category : #accessing }
CTBaseSlotDescriptor >> isOneToMany [

	^ isOneToMany
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

	self inlinePredicate: [ :level :default | false ]
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
CTBaseSlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
CTBaseSlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
CTBaseSlotDescriptor >> valueShapeOf: anObject walker: aDfsWalker [

	^ aDfsWalker defaultShapeOf: anObject
]

{ #category : #accessing }
CTBaseSlotDescriptor >> varShapeOf: anObject walker: walker [

	^ walker shapeBuilder label: anObject var: self selector
]
