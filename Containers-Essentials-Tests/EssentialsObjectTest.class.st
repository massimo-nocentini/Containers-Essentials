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
EssentialsObjectTest >> testInspect10GoldenRatios [

	| ratios |
	ratios := 10 goldenRatiosLower.

	self
		assert: ratios
		equals:
			#( 1.618033988749895 1 0.6180339887498949 0.3819660112501051
			   0.2360679774997898 0.1458980337503153 0.09016994374947451
			   0.05572809000084078 0.03444185374863373 0.021286236252207047 ).

	^ self exportSlotsGraphOf: ratios
]

{ #category : #tests }
EssentialsObjectTest >> testInspect10GoldenRectangles [

	| rectangles |
	rectangles := RSGroup withAll:
		              (self testInspect10GoldenRatios 
			               overlappingPairsCollect: [ :width :height | 
				               RSBox new
					               cornerRadius: Float goldenRatio double;
					               extent: width @ height * 100;
					               color: Color white;
					               withBorder;
					               yourself ]).

	^ self exportSlotsGraphOf: rectangles
]

{ #category : #tests }
EssentialsObjectTest >> testInspect10GoldenRectanglesNested [

	| rectangles |
	rectangles := self testInspect10GoldenRectangles foldr1: [ :each :aBox | 
		              aBox rotateByRadians: Float pi half negated.
		              RSLocation new left stick: aBox on: each.
		              RSComposite new
			              shapes: { 
					              each.
					              aBox };
			              yourself ].

	^ self exportShapeOf: rectangles
]

{ #category : #tests }
EssentialsObjectTest >> testInspect20CatalanNumbers [

	| catalan |
	catalan := 20 catalanNumbers.

	self
		assert: -3 catalanNumbers equals: #(  );
		assert: 0 catalanNumbers equals: #(  );
		assert: catalan
		equals:
			#( 1 1 2 5 14 42 132 429 1430 4862 16796 58786 208012 742900 2674440
			   9694845 35357670 129644790 477638700 1767263190 ).

	^ self exportSlotsGraphOf: catalan
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

	^ self exportSlotsGraphOf:
		  ((0 to: 15) collect: [ :each | each asShapeBRGCDots ] as: RSGroup)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectBag [

	^ self exportSlotsGraphOf: (Bag withAll: String loremIpsum)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectCatalanArray [

	^ self exportSlotsGraphOf: (Array2D catalan: 1 << 4)
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
EssentialsObjectTest >> testInspectFalse [

	^ self exportSlotsGraphOf: false
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
EssentialsObjectTest >> testInspectIceRepository [

	self skip.

	^ self exportSlotsGraphOf:
		  (IceRepository registry detect: [ :each | 
			   each name = 'Containers-HeapQ' ])
]

{ #category : #tests }
EssentialsObjectTest >> testInspectIceRepositoryCommitsGraph [

	^ self
		  exportShapeOf: (IceRepository registry detect: [ :each | 
				   each name = 'Containers-HeapQ' ])
		  accessorBlock: #asShapeCommitsGraph
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13 [

	^ self exportSlotsGraphOf: 13
]

{ #category : #tests }
EssentialsObjectTest >> testInspectInteger13Detailed [

	^ self
		  exportSlotsGraphOf: 13
		  slotDescriptorsContext: CTSlotDescriptorsVisitorIntegerDetails new
]

{ #category : #tests }
EssentialsObjectTest >> testInspectLargeInteger [

	| large n |
	n := 42 factorial.
	large := n karatsuba: n base: 10.

	self
		assert: large equals: n * n;
		assert: (n dcMultiplyIntegerSlow: n base: 10) equals: large.

	^ self exportSlotsGraphOf: large
]

{ #category : #tests }
EssentialsObjectTest >> testInspectLargeIntegerBench [

	| m n r1 r2 r3 r4 |
	self
		skip;
		timeLimit: 25 seconds.

	m := 8353243857638976935086973908547693709653846039568038760978045789065879065856478267589356845765897395867394867947369.
	n := 71443585763986790386779308765994675736783265452687685768365873564832756482763598273658736462354785628976982756982765239.

	([ r1 := m karatsuba: n base: 10 ] benchFor: 5 seconds) iterations. " 964"

	([ r2 := m * n ] benchFor: 5 seconds) iterations. " 18259186"

	([ r3 := m karatsuba: n base: 10 ] benchFor: 5 seconds) iterations. " 928"

	([ r4 := m karatsuba: n base: 10 ] benchFor: 5 seconds) iterations. " 903"

	self
		assert: r1 equals: r2;
		assert: r2 equals: r3;
		assert: r3 equals: r4
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

	^ self exportSlotsGraphOf: Object
]

{ #category : #tests }
EssentialsObjectTest >> testInspectOneToMany [

	^ self
		  exportSlotsGraphOf: { 'hello'. 'world' } ~~> ({ 
				   42 asValueHolder.
				   Float goldenRatio asValueHolder } ~~> nil)
		  slotDescriptorsContext:
		  SlotDescriptorsVisitorOneToManyForValueLinkTesting new
]

{ #category : #tests }
EssentialsObjectTest >> testInspectPascalArray [

	^ self exportSlotsGraphOf: (Array2D pascal: 1 << 4)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectPoint [

	^ self exportSlotsGraphOf: 42 @ 24
]

{ #category : #tests }
EssentialsObjectTest >> testInspectProbabilisticMedianRatioWithSorting [

	| n random collection randomized sorting middle v w |
	self timeLimit: 6 seconds.

	n := 1e5.
	random := Random seed: 541.
	collection := OrderedCollection new.
	1 to: n do: [ :i | collection add: (random nextInteger: n) ].

	middle := (collection size / 2) floor.

	randomized := [ 
	              v := collection
		                   kth: middle
		                   ranking: [ :each :pivot | each < pivot ]
		                   atRandom: random ] benchFor: 2 seconds.

	sorting := [ w := collection sorted at: middle ] benchFor: 2 seconds.

	self assert: v equals: w.

	self assert: ((randomized iterations / sorting iterations) asFloat
			 between: 2
			 and: 3)
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
EssentialsObjectTest >> testInspectSkewBinaryCanonicalSparse [

	| skewNumbers backwards |
	skewNumbers := (1 to: 20) collect: [ :each | 
		               each asSkewBinaryCanonicalSparse yourself: [ :skew | 
			               self assert: skew asInteger equals: each ] ].

	self exportSlotsGraphOf: skewNumbers pathSuffix: 'increasing'.

	backwards := skewNumbers reversed
		             with: (19 to: 0 by: -1)
		             collect: [ :skew :each | 
			             skew decrement yourself: [ :previous | 
				             self assert: previous asInteger equals: each ] ].

	self exportSlotsGraphOf: backwards pathSuffix: 'decreasing'
]

{ #category : #tests }
EssentialsObjectTest >> testInspectString [

	^ self exportSlotsGraphOf: (String loremIpsum: 100)
]

{ #category : #tests }
EssentialsObjectTest >> testInspectTrue [

	^ self exportSlotsGraphOf: true
]

{ #category : #tests }
EssentialsObjectTest >> testInversions [

	self
		assert: ((1 to: 100) asArray sizeInversions: [ :i :j | i < j ])
		equals: 0.

	self
		assert: ((1 to: 100) reversed sizeInversions: [ :i :j | i < j ])
		equals: (1 to: 100 - 1) sum.

	"https://towardsdatascience.com/basic-algorithms-counting-inversions-71aaa579a2c0"
	self
		assert: ({ 2. 3. 8. 6. 1 } inversions: [ :i :j | i < j ])
		equals: { 
				(1 -> 6).
				(1 -> 2).
				(1 -> 3).
				(1 -> 8).
				(6 -> 8) }.

	"https://www.interviewbit.com/blog/count-inversions-of-an-array/"
	self
		assert: ({ 6. 3. 5. 2. 7 } inversions: [ :i :j | i < j ])
		equals: { 
				(3 -> 6).
				(5 -> 6).
				(2 -> 3).
				(2 -> 5).
				(2 -> 6) }.

	"https://people.cs.umass.edu/~sheldon/teaching/mhc/cs312/2013sp/Slides/Slides13%20-%20Counting%20Inversions.pdf"
	self
		assert:
			({ 1. 5. 4. 8. 10. 2. 6. 9. 12. 11. 3. 7 } sizeInversions: [ :i :j | 
				 i < j ])
		equals: 22
]

{ #category : #tests }
EssentialsObjectTest >> testLinkSubclasses [

	^ self exportShapeOf: Link accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclasses [

	^ self exportShapeOf: Magnitude accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclassesSlotsGraph [

	^ self
		  exportSlotsGraphOf: Magnitude
		  slotDescriptorsContext: CTSlotDescriptorsVisitorClassHierarchy new
]

{ #category : #tests }
EssentialsObjectTest >> testRBNodeSubclasses [

	^ self exportShapeOf: RBNode accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testRandomSubclasses [

	^ self exportShapeOf: Random accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testWithIntegersCollectionDo [

	{ 
		Object new.
		Object new.
		Object new } withIntegersCollectionDo: [ :iCollection :map | 
		self assert: iCollection equals: #( 0 1 2 ) ]
]

{ #category : #tests }
EssentialsObjectTest >> testWithIntegersCollectionDoLoremIpsum [

	String loremIpsum withIntegersCollectionDo: [ :iCollection :map | 
		self
			assert: iCollection
			equals:
				#( 0 1 2 3 4 5 6 7 8 9 4 5 10 1 11 1 2 5 8 6 12 5 13 4 3 12 14 5 15
				   1 16 8 3 15 12 3 12 9 2 5 13 10 6 7 6 8 15 6 16 17 5 3 11 6 12
				   14 5 8 3 10 5 10 1 5 3 6 9 8 4 1 10 5 12 3 4 7 1 2 5 6 16 15 6
				   10 6 10 9 16 12 5 9 12 5 11 13 18 1 2 3 5 3 12 5 10 1 11 1 2 3
				   5 4 13 17 16 13 5 13 11 6 19 9 13 20 5 21 12 5 3 16 6 4 5 13 10
				   5 4 6 16 6 4 5 22 3 16 6 13 4 14 5 19 9 6 8 5 16 1 8 12 2 9 10
				   5 3 23 3 2 15 6 12 13 12 6 1 16 5 9 11 11 13 4 15 1 5 11 13 18
				   1 2 6 8 5 16 6 8 6 5 9 12 5 13 11 6 19 9 6 7 5 3 23 5 3 13 5 15
				   1 4 4 1 10 1 5 15 1 16 8 3 19 9 13 12 20 5 24 9 6 8 5 13 9 12
				   3 5 6 2 9 2 3 5 10 1 11 1 2 5 6 16 5 2 3 7 2 3 25 3 16 10 3 2 6
				   12 5 6 16 5 22 1 11 9 7 12 13 12 3 5 22 3 11 6 12 5 3 8 8 3 5 15
				   6 11 11 9 4 5 10 1 11 1 2 3 5 3 9 5 26 9 17 6 13 12 5 16 9 11
				   11 13 5 7 13 2 6 13 12 9 2 20 5 27 23 15 3 7 12 3 9 2 5 8 6 16
				   12 5 1 15 15 13 3 15 13 12 5 15 9 7 6 10 13 12 13 12 5 16 1 16
				   5 7 2 1 6 10 3 16 12 14 5 8 9 16 12 5 6 16 5 15 9 11 7 13 5 19
				   9 6 5 1 26 26 6 15 6 13 5 10 3 8 3 2 9 16 12 5 4 1 11 11 6 12
				   5 13 16 6 4 5 6 10 5 3 8 12 5 11 13 18 1 2 9 4 20 ) ]
]

{ #category : #tests }
EssentialsObjectTest >> testWithIntegersCollectionDoSharingObjects [

	| t o |
	o := Object new.
	t := Object new.

	{ 
		1.
		o.
		t.
		o.
		1 } withIntegersCollectionDo: [ :iCollection :map | 
		self
			assert: iCollection equals: #( 0 1 2 1 0 );
			assert: (map value: iCollection first) equals: 1;
			assert: (map value: iCollection second) equals: o;
			assert: (map value: iCollection third) equals: t;
			assert: (map value: iCollection fourth) equals: o;
			assert: (map value: iCollection fifth) equals: 1 ]
]

{ #category : #tests }
EssentialsObjectTest >> testWithIntegersCollectionDoThreeDifferentObjects [

	{ 
		Object new.
		Object new.
		Object new } withIntegersCollectionDo: [ :iCollection :map | 
		self assert: iCollection equals: #( 0 1 2 ) ]
]
