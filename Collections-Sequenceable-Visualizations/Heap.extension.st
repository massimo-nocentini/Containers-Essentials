Extension { #name : #Heap }

{ #category : #'*Collections-Sequenceable-Visualizations' }
Heap >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 90 title: 'Values tree'>
	| shapes heap edgeBuilder evenEdges oddEdges edges indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	shapes := heap withIndexCollect: [ :each :i | 
		          | valueShape indexShape |
		          indexes at: each put: i.
		          valueShape := RSLabel new
			                        model: each;
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

	RSHorizontalVanDerPloegTreeLayout on: shapes edges: edges.

	^ RSCanvas new
		  addAll: shapes;
		  addAll: edges;
		  addInteraction: RSCanvasControllerInteraction new;
		  inspectorCanvas
]

{ #category : #'*Collections-Sequenceable-Visualizations' }
Heap >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]
