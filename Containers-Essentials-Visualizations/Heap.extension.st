Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitHeap: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeBubblesHorizontalTree [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent."

	| heap indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	heap withIndexDo: [ :each :i | indexes at: each put: i ].

	^ (self class asShapeBubblesHorizontalTree: heap indexes: indexes)
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
Heap class >> asShapeHorizontalTreeWithShapes: aCollectionOfShapes array: array indexes: indexes [

	| edgeBuilder evenEdges oddEdges edges tally |
	tally := array size.

	edgeBuilder := RSEdgeBuilder horizontalBezier
		               withHorizontalAttachPoint;
		               shapes: aCollectionOfShapes.

	evenEdges := edgeBuilder connectTo: [ :each | 
		             | index |
		             index := (indexes at: each) << 1.
		             index <= tally ifTrue: [ array at: index ] ].

	oddEdges := edgeBuilder dashed connectTo: [ :each | 
		            | index |
		            index := (indexes at: each) << 1 bitOr: 1.
		            index <= tally ifTrue: [ array at: index ] ].

	edges := evenEdges , oddEdges.

	RSHorizontalGaussianJitterVanDerPloegTreeLayout
		on: aCollectionOfShapes
		edges: edges.

	^ RSComposite new
		  shapes: aCollectionOfShapes , edges;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeValuesHorizontalTree [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent."

	| heap indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	heap withIndexDo: [ :each :i | indexes at: each put: i ].

	^ (self class asShapeValuesHorizontalTree: heap indexes: indexes)
		  model: self;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap class >> asShapeValuesHorizontalTree: array indexes: indexes [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent.
	
	 Nodes are represented as labels with their corresponding positions as subscripts."

	| shapes |
	shapes := array collect: [ :each | 
		          | valueShape indexShape i |
		          i := indexes at: each.

		          valueShape := RSLabel new
			                        model: each;
			                        fontName: 'Source Code Pro';
			                        yourself.

		          indexShape := RSLabel new
			                        model: i;
			                        text: '(' , i asString , ')';
			                        fontSize:
				                        valueShape fontSize * Float silverRatio;
			                        yourself.
		          RSLocation new bottom right
			          offset: indexShape textWidth + Float goldenRatio @ 0;
			          move: indexShape on: valueShape.
		          RSComposite new
			          model: each;
			          addShape: valueShape;
			          addShape: indexShape;
			          adjustToChildren;
			          padding: Float goldenRatio double;
			          draggable;
			          yourself ].

	^ self
		  asShapeHorizontalTreeWithShapes: shapes
		  array: array
		  indexes: indexes
]
