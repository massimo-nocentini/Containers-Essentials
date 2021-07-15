Class {
	#name : #EssentialsObjectTest,
	#superclass : #ObjectTest,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests'
}

{ #category : #tests }
EssentialsObjectTest >> testCollectionSubclasses [

	^ self exportShapeOf: Collection accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testInspect20FibonacciNumbers [

	| fibs a b n |
	n := 20.
	a := 0.
	b := 1.
	fibs := Array streamContents: [ :aStream | 
		        aStream
			        nextPut: a;
			        nextPut: b.
		        3 to: 20 do: [ :each | 
			        | c |
			        c := aStream nextPut: a + b.
			        a := b.
			        b := c ] ].

	^ self exportSlotsGraphOf: fibs
]

{ #category : #tests }
EssentialsObjectTest >> testInspectAssociation [

	^ self exportSlotsGraphOf: 42 -> thisContext method
]

{ #category : #tests }
EssentialsObjectTest >> testInspectBRGCodes [

	^ self
		  exportSlotsGraphOf:
		  ((0 to: 15) collect: [ :each | each asShapeBRGCDots ])
		  slotsBlock: [ :anObject | 
			  anObject instVarsNamesOrderedCollection collect: [ :aDescriptor | 
				  aDescriptor
					  inline: true;
					  quote ] ]
]

{ #category : #tests }
EssentialsObjectTest >> testInspectCharacterPi [

	^ self exportSlotsGraphOf: $π
]

{ #category : #tests }
EssentialsObjectTest >> testInspectDatetimeNow [

	^ self exportSlotsGraphOf: DateAndTime now
]

{ #category : #tests }
EssentialsObjectTest >> testInspectGoldenRatio [

	^ self exportSlotsGraphOf: Float goldenRatio
]

{ #category : #tests }
EssentialsObjectTest >> testInspectHeap [

	| array random |
	random := Random seed: 11.
	array := (1 to: 30) asArray shuffleBy: random.
	self
		assert: array
		equals:
			#( 12 16 22 30 8 17 15 4 20 19 28 18 27 21 24 10 7 3 14 5 6 26 25
			   29 11 23 2 9 13 1 ).

	^ self exportSlotsGraphOf: (Heap withAll: array)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13 [

	^ self exportSlotsGraphOf: 13
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13Detailed [

	^ self exportSlotsGraphOf: 13 asDetailedRepresentationsView
]

{ #category : #tests }
EssentialsObjectTest >> testInspectObjectModel [

	^ self exportSlotsGraphOf: { 
			  Object.
			  Trait }
]

{ #category : #tests }
EssentialsObjectTest >> testInspectPoint [

	^ self exportSlotsGraphOf: 42 @ 100
]

{ #category : #tests }
EssentialsObjectTest >> testInspectString [

	^ self exportSlotsGraphOf: (String loremIpsum: 100)
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclasses [

	^ self exportShapeOf: Magnitude accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclassesSlotsGraph [

	^ self exportSlotsGraphOf: Magnitude slotsBlock: [ :anObject | 
		  anObject
			  instVarsNamesOrderedCollection_testMagnitudeSubclassesSlotsGraph ]
]

{ #category : #tests }
EssentialsObjectTest >> testRBNodeSubclasses [

	^ self exportShapeOf: RBNode accessorBlock: #asShapeSubclasses
]
