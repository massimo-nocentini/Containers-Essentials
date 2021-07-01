Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> asShapeValueTree [

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

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 90 title: 'Values tree'>
	^ RSCanvas new
		  add: self asShapeValueTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { (#asShapeValueTree asSlotDescriptor
			   selectorHasBeenGiven;
			   inline: true;
			   quote) }
]
