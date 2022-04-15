Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitHeap: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeBubblesHorizontalTree [

	^ self asShapeBubblesHorizontalTree: CTDfsWalker new
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeBubblesHorizontalTree: aDfsWalker [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent."

	| heap indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	heap withIndexDo: [ :each :i | indexes at: each put: i ].

	^ (self class
		   asShapeBubblesHorizontalTree: heap
		   indexes: indexes
		   walker: aDfsWalker)
		  model: self;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeBubblesHorizontalTree: array indexes: indexes [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent.
	
	 Nodes are represented as circles such that their areas equals their #value."

	| shapes |
	shapes := array collect: [ :each | 
		          RSCircle new
			          model: each;
			          radius: (each / Float pi) sqrt * Float goldenRatio double;
			          color: Color white;
			          withBorder;
			          addInteraction: RSPopup new ].

	^ self
		  asShapeHorizontalTreeWithShapes: shapes
		  array: array
		  indexes: indexes
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeBubblesHorizontalTree: array indexes: indexes walker: aDfsWalker [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent.
	
	 Nodes are represented as circles such that their areas equals their #value."

	| shapes |
	shapes := array collect: [ :each | 
		          RSCircle new
			          model: each;
			          radius:
				          (each / Float pi) sqrt
				          * aDfsWalker shapeBuilder radiusOrPadding;
			          color: Color white;
			          withBorder;
			          addInteraction: RSPopup new ].

	^ self
		  asShapeHorizontalTreeWithShapes: shapes
		  array: array
		  indexes: indexes
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeHorizontalTreeWithShapes: aCollectionOfShapes array: array indexes: indexes [

	| edgeBuilder evenEdges oddEdges edges tally |
	tally := array size.

	edgeBuilder := RSLineBuilder horizontalDeCasteljauSegmentedLine
		               withHorizontalAttachPoint;
		               shapes: aCollectionOfShapes.

	evenEdges := edgeBuilder connectTo: [ :each | 
		             | index |
		             index := (indexes at: each) << 1.
		             index <= tally ifTrue: [ array at: index ] ].

	oddEdges := edgeBuilder
		            dashed;
		            connectTo: [ :each | 
			            | index |
			            index := (indexes at: each) << 1 bitOr: 1.
			            index <= tally ifTrue: [ array at: index ] ].

	edges := evenEdges , oddEdges.

	RSHorizontalVanDerPloegTreeLayout
		on: aCollectionOfShapes
		edges: edges.

	^ RSComposite new
		  shapes: aCollectionOfShapes , edges;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeValuesHorizontalTree [

	^ self asShapeValuesHorizontalTree: nil
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeValuesHorizontalTree: aDfsWalker [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent."

	| heap indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	heap withIndexDo: [ :each :i | indexes at: each put: i ].

	^ (self class
		   asShapeValuesHorizontalTree: heap
		   indexes: indexes
		   walkerOrNil: aDfsWalker)
		  model: self;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeValuesHorizontalTree: array indexes: indexes [

	^ self
		  asShapeValuesHorizontalTree: array
		  indexes: indexes
		  walkerOrNil: nil
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeValuesHorizontalTree: array indexes: indexes walkerOrNil: nullableDfsWalker [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent.
	
	 Nodes are represented as labels with their corresponding positions as subscripts."

	| shapes aDfsWalker |
	aDfsWalker := nullableDfsWalker ifNil: [ CTDfsWalker new ].

	shapes := array collect: [ :each | 
		          | valueShape indexShape i |
		          i := indexes at: each.

		          valueShape := nullableDfsWalker
			                        ifNil: [ 
				                        RSLabel new
					                        model: each;
					                        useDefaultCodeFont;
					                        yourself ]
			                        ifNotNil: [ 
			                        each asShapeSlotsDfsTree: aDfsWalker ].

		          indexShape := RSLabel new
			                        model: i;
			                        text: '(' , i asString , ')';
			                        fontSizeSilverRatio;
			                        yourself.

		          RSLocation new bottom right
			          offset:
				          indexShape textWidth
				          + aDfsWalker shapeBuilder radiusOrPadding @ 0;
			          stick: indexShape on: valueShape.

		          RSComposite new
			          model: each;
			          addShape: valueShape;
			          addShape: indexShape;
			          padding: aDfsWalker shapeBuilder radiusOrPadding;
			          draggable;
			          yourself ].

	^ self
		  asShapeHorizontalTreeWithShapes: shapes
		  array: array
		  indexes: indexes
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> inspectorCanvasBubblesTree [

	<inspectorPresentationOrder: 90 title: 'Bubbles tree'>
	^ RSCanvas new
		  @ RSCanvasController;
		  add: self asShapeBubblesHorizontalTree;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> inspectorCanvasBubblesTreeContext: aContext [

	aContext withoutEvaluator
]
