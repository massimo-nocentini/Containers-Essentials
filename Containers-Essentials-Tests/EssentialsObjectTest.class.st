Class {
	#name : #EssentialsObjectTest,
	#superclass : #ObjectTest,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests'
}

{ #category : #tests }
EssentialsObjectTest >> testByteArrayInteger [

	^ self exportSlotsGraphOf: 50 fibonacciNumbers last asByteArray
]

{ #category : #tests }
EssentialsObjectTest >> testByteArrayLiteral [

	^ self exportSlotsGraphOf: #[ 18 10 253 ]
]

{ #category : #tests }
EssentialsObjectTest >> testByteArrayLoremIpsum [

	^ self exportSlotsGraphOf: (String loremIpsum: 50) asByteArray
]

{ #category : #tests }
EssentialsObjectTest >> testCollectionSubclasses [

	^ self exportShapeOf: Collection accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testInspect20FibonacciNumbers [

	| fibs |
	fibs := 20 fibonacciNumbers.

	self
		assert: -3 fibonacciNumbers equals: #(  );
		assert: 0 fibonacciNumbers equals: #(  );
		assert: 1 fibonacciNumbers equals: #( 0 );
		assert: 2 fibonacciNumbers equals: #( 0 1 );
		assert: fibs
		equals:
			#( 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 ).

	^ self exportSlotsGraphOf: fibs
]

{ #category : #tests }
EssentialsObjectTest >> testInspect20LucasNumbers [

	| lucas |
	lucas := 20 lucasNumbers.

	self
		assert: -3 lucasNumbers equals: #(  );
		assert: 0 lucasNumbers equals: #(  );
		assert: 1 lucasNumbers equals: #( 2 );
		assert: 2 lucasNumbers equals: #( 2 1 );
		assert: lucas
		equals:
			#( 2 1 3 4 7 11 18 29 47 76 123 199 322 521 843 1364 2207 3571 5778
			   9349 ).

	^ self exportSlotsGraphOf: lucas
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
		  slotDescriptorsContext:
			  (SlotDescriptorsVisitor new collect: [ :aDescriptor | 
				   aDescriptor
					   inline: true;
					   quote ])
]

{ #category : #tests }
EssentialsObjectTest >> testInspectBag [

	^ self exportSlotsGraphOf: (Bag withAll: String loremIpsum)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectCharacterPi [

	^ self exportSlotsGraphOf: $π
]

{ #category : #tests }
EssentialsObjectTest >> testInspectColorGray [

	^ self exportSlotsGraphOf: Color gray translucent
]

{ #category : #tests }
EssentialsObjectTest >> testInspectContext [

	^ self exportSlotsGraphOf: thisContext
]

{ #category : #tests }
EssentialsObjectTest >> testInspectContinuation [

	self
		skip;
		timeLimit: 5 minutes.

	^ self exportSlotsGraphOf:
		  (Continuation currentDo: [ :aContinuation | 
			   1 + (aContinuation value: aContinuation) ])
]

{ #category : #tests }
EssentialsObjectTest >> testInspectDatetimeNow [

	^ self exportSlotsGraphOf: DateAndTime now
]

{ #category : #tests }
EssentialsObjectTest >> testInspectDictionary [

	^ self exportSlotsGraphOf: (Dictionary new
			   at: 1 put: 'Hello';
			   at: 2 -> 3 put: 4;
			   at: 'World' put: #Smalltalk;
			   yourself)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFloatPi [

	^ self exportSlotsGraphOf: Float π
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFraction [

	^ self exportSlotsGraphOf: -1 / 2
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFractionForKisses [

	^ self exportSlotsGraphOf: 4 / 17
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFractionKissing [

	| aFraction |
	aFraction := self testInspectFractionForKisses.

	self assert: aFraction kissingFractions equals: { 
			(1 / 5).
			(2 / 9).
			(3 / 13).
			(4 / 17).
			(1 / 4).
			(1 / 3).
			(1 / 2) }.

	^ self exportShapeOf: aFraction accessorBlock: #asShapeFordCircles
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFractionKissingEnumeration [

	| fractions n |
	n := 7.
	fractions := [ :f :seen :frontier :level | level < n ]
		             kissingFractions.

	self assert: fractions size equals: 1 << (n - 1) - 1.

	self assert: fractions equals: { 
			(1 / 7).
			(1 / 6).
			(2 / 11).
			(1 / 5).
			(3 / 14).
			(2 / 9).
			(3 / 13).
			(1 / 4).
			(4 / 15).
			(3 / 11).
			(5 / 18).
			(2 / 7).
			(5 / 17).
			(3 / 10).
			(4 / 13).
			(1 / 3).
			(5 / 14).
			(4 / 11).
			(7 / 19).
			(3 / 8).
			(8 / 21).
			(5 / 13).
			(7 / 18).
			(2 / 5).
			(7 / 17).
			(5 / 12).
			(8 / 19).
			(3 / 7).
			(7 / 16).
			(4 / 9).
			(5 / 11).
			(1 / 2).
			(6 / 11).
			(5 / 9).
			(9 / 16).
			(4 / 7).
			(11 / 19).
			(7 / 12).
			(10 / 17).
			(3 / 5).
			(11 / 18).
			(8 / 13).
			(13 / 21).
			(5 / 8).
			(12 / 19).
			(7 / 11).
			(9 / 14).
			(2 / 3).
			(9 / 13).
			(7 / 10).
			(12 / 17).
			(5 / 7).
			(13 / 18).
			(8 / 11).
			(11 / 15).
			(3 / 4).
			(10 / 13).
			(7 / 9).
			(11 / 14).
			(4 / 5).
			(9 / 11).
			(5 / 6).
			(6 / 7) }.

	^ self exportShapeOf: fractions accessorBlock: #asShapeFordCircles
]

{ #category : #tests }
EssentialsObjectTest >> testInspectFractionReciprocalKissing [

	| aFraction |
	aFraction := self testInspectFractionKissing reciprocal.

	self assert: aFraction kissingFractions equals: { 
			(1 / 4).
			(1 / 3).
			(1 / 2) }.

	^ self exportShapeOf: aFraction accessorBlock: #asShapeFordCircles
]

{ #category : #tests }
EssentialsObjectTest >> testInspectGoldenRatio [

	^ self exportSlotsGraphOf: Float goldenRatio
]

{ #category : #tests }
EssentialsObjectTest >> testInspectHeap [

	| array random heap |
	random := Random seed: 11.
	array := (1 to: 30) asArray shuffleBy: random.
	self
		assert: array
		equals:
			#( 12 16 22 30 8 17 15 4 20 19 28 18 27 21 24 10 7 3 14 5 6 26 25
			   29 11 23 2 9 13 1 ).

	heap := Heap new.

	self exportSlotsGraphOf: heap.

	array withIndexDo: [ :each :i | 
		heap add: each.

		self exportSlotsGraphOf: heap pathSuffix: i asString ]
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13 [

	^ self exportSlotsGraphOf: 13
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13Detailed [

	^ self
		  exportSlotsGraphOf: 13
		  slotDescriptorsContext: SlotDescriptorsVisitorIntegerDetails new
]

{ #category : #tests }
EssentialsObjectTest >> testInspectNil [

	^ self exportSlotsGraphOf: nil
]

{ #category : #tests }
EssentialsObjectTest >> testInspectObject [

	^ self exportSlotsGraphOf: Object new
]

{ #category : #tests }
EssentialsObjectTest >> testInspectObjectModel [

	^ self exportSlotsGraphOf: { 
			  Object.
			  Trait }
]

{ #category : #tests }
EssentialsObjectTest >> testInspectPoint [

	^ self exportSlotsGraphOf: 42 @ 24
]

{ #category : #tests }
EssentialsObjectTest >> testInspectRBNodesQuine [

	| quine aQuineBlock evalBlock |
	aQuineBlock := [ :x | 
	               RBMessageNode
		               receiver: x
		               selector: #value:
		               arguments:
		               { (RBMessageNode receiver: x selector: #sourceNode) } ].

	quine := aQuineBlock value: aQuineBlock sourceNode.

	evalBlock := OpalCompiler new
		             source:
			             (RBBlockNode body:
					              (RBSequenceNode statements: { quine }))
				             formattedCode;
		             evaluate.

	self assert: evalBlock value equals: quine
]

{ #category : #tests }
EssentialsObjectTest >> testInspectRSPolygon [

	^ self exportSlotsGraphOf: (RSPolygon new
			   points: { 
					   (0 @ 0).
					   (100 @ 25).
					   (200 @ 0) };
			   cornerRadii: Float goldenRatio double;
			   yourself)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectSet [

	| random sample n |
	n := 20.
	random := Random seed: 11.
	sample := (1 to: n) collect: [ :i | random nextInteger: n ].

	self
		assert: sample
		equals: #( 1 9 7 1 18 9 11 10 10 6 5 15 3 8 12 17 8 2 5 15 ).

	^ self exportSlotsGraphOf: sample asSet
]

{ #category : #tests }
EssentialsObjectTest >> testInspectString [

	^ self exportSlotsGraphOf: (String loremIpsum: 100)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectTrueAndFalse [

	^ self
		  exportSlotsGraphOf: (Array with: true with: false)
		  slotDescriptorsContext:
			  (SlotDescriptorsVisitor new collect: [ :aDescriptor | 
				   aDescriptor inline: false ])
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclasses [

	^ self exportShapeOf: Magnitude accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclassesSlotsGraph [

	^ self
		  exportSlotsGraphOf: Magnitude
		  slotDescriptorsContext: SlotDescriptorsVisitorClassHierarchy new
]

{ #category : #tests }
EssentialsObjectTest >> testRBNodeSubclasses [

	^ self exportShapeOf: RBNode accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testRandomSubclasses [

	^ self exportShapeOf: Random accessorBlock: #asShapeSubclasses
]
