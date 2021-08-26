Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitHeap: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeValueTree [

	"This visualization represents the current Heap object as a binary tree,
	 where a solid edge denotes the child at position 2n and a dashed edge
	 denotes a child at position 2n + 1, where n is the position of the parent."

	| shapes heap edgeBuilder evenEdges oddEdges edges indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	shapes := heap withIndexCollect: [ :each :i | 
		          | valueShape indexShape |
		          indexes at: each put: i.
		          valueShape := RSLabel new
			                        model: each;
			                        fontName: 'Source Code Pro';
			                        yourself.
		          indexShape := RSLabel new
			                        model: i;
			                        text: '(' , i asString , ')';
			                        fontSize: valueShape fontSize >> 1;
			                        yourself.
		          RSLocation new bottom right
			          offset: indexShape textWidth + 2 @ 0;
			          move: indexShape on: valueShape.
		          RSComposite new
			          model: each;
			          addShape: valueShape;
			          addShape: indexShape;
			          adjustToChildren;
			          padding: 2;
			          draggable;
			          yourself ].

	edgeBuilder := RSEdgeBuilder horizontalBezier
		               withHorizontalAttachPoint;
		               shapes: shapes.

	evenEdges := edgeBuilder connectTo: [ :each | 
		             | index |
		             index := (indexes at: each) << 1.
		             index <= tally ifTrue: [ heap at: index ] ].

	oddEdges := edgeBuilder dashed connectTo: [ :each | 
		            | index |
		            index := (indexes at: each) << 1 bitOr: 1.
		            index <= tally ifTrue: [ heap at: index ] ].

	edges := evenEdges , oddEdges.

	RSHorizontalGaussianJitterVanDerPloegTreeLayout
		on: shapes
		edges: edges.

	^ RSComposite new
		  model: self;
		  shapes: shapes , edges;
		  yourself
]
