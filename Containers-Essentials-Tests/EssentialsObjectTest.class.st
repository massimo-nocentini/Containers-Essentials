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

	^ self exportSlotsGraphOf: (Heap withAll: (1 to: 100) shuffled)
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
EssentialsObjectTest >> testInspectObjectClass [

	^ self exportSlotsGraphOf: Object
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
EssentialsObjectTest >> testInspectTraitClass [

	^ self exportSlotsGraphOf: Trait
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclasses [

	^ self exportShapeOf: Magnitude accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclassesSlotsGraph [

	^ self exportSlotsGraphOf: Magnitude slotsBlock: [ :anObject | 
		  anObject isClass
			  ifTrue: [ 
				  { 
					  #name asSlotDescriptor.
					  "(#comment asSlotDescriptor inline: true)."
					  (#instVarNames asSlotDescriptor inline: true).
					  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
						   anObject subclasses ifEmpty: [ aDescriptor inline: true ] ]) } ]
			  ifFalse: [ anObject instVarsNamesOrderedCollection ] ]
]

{ #category : #tests }
EssentialsObjectTest >> testRBNodeSubclasses [

	^ self exportShapeOf: RBNode accessorBlock: #asShapeSubclasses
]
