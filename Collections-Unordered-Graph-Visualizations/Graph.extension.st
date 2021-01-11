Extension { #name : #Graph }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal3
		  title: 'Graph';
		  initializeCanvas: [ 
			  self
				  gtInspectorGraphViewUsingMondrianBuilder: RSCanvas new
				  vertex: [ :aVertex | 
					  RSLabel new
						  text: aVertex content;
						  color: Color black;
						  yourself ]
				  edge: [ :eb | 
					  eb line 
						  color: Color lightGray translucent;
						  yourself ]
				  layout: [ :shapes :edgesShapes | 
					  RSForceBasedLayout on: shapes edges: edgesShapes ] ];
		  yourself
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewUsingMondrianBuilder: canvas vertex: sBlock edge: eBlock layout: lBlock [
	| eb shapes edgesShapes |
	"Setting up the nodes"
	shapes := self vertices values collect: [ :aVertex | 
		          | shape |
		          shape := sBlock cull: aVertex.
		          shape
			          draggable;
			          model: aVertex;
			          yourself ].
	canvas addAll: shapes shuffled.

	"Setting up the edges"
	eb := eBlock value: RSEdgeBuilder.
	edgesShapes := eb
		               canvas: canvas;
		               shapes: shapes;
		               useAssociations: self associations.
	lBlock value: shapes value: edgesShapes.

	"Some decorators"
	"canvas @ RSDraggableCanvas @ RSCanvasController."
	^ canvas
]
