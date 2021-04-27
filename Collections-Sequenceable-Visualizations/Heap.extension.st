Extension { #name : #Heap }

{ #category : #'*Collections-Sequenceable-Visualizations' }
Heap >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 90 title: 'Values tree'>
	| shapes heap edgeBuilder evenEdges oddEdges edges indexes |
	indexes := IdentityDictionary new.
	heap := array copyFrom: 1 to: tally.
	shapes := heap withIndexCollect: [ :each :i | 
		          | value index |
		          indexes at: each put: i.
		          value := RSLabel new
			                   model: each;
			                   yourself.
		          index := RSLabel new
			                   model: i;
			                   text: '(' , i asString , ')';
			                   fontSize: value fontSize >> 1;
			                   yourself.
		          RSLocation new bottom right
			          offset: index textWidth + 1 @ 0;
			          move: index on: value.
		          RSComposite new
			          model: each;
			          addShape: value;
			          addShape: index;
			          adjustToChildren;
			          padding: 2;
			          yourself ].

	edgeBuilder := RSEdgeBuilder horizontalBezier
		               withBorderAttachPoint;
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

	RSHorizontalTreeLayout on: shapes edges: edges.

	^ RSCanvas new
		  addAll: shapes;
		  addAll: edges;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Collections-Sequenceable-Visualizations' }
Heap >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]
