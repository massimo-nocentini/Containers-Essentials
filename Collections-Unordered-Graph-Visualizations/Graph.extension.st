Extension { #name : #Graph }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal3
		title: 'Graph';
		initializeCanvas: [ self
				gtInspectorGraphViewUsingMondrianBuilder: RSCanvas new
				vertex: [ :aVertex | 
					RSLabel new
						text: aVertex content;
						color: Color black;
						yourself ]
				edge: [ :eb | 
					eb verticalBezier
						color: Color lightGray translucent;
					"	withBorderAttachPoint ;"
						"cornerRadii: 50;"
							"withVerticalAttachPoint;"
							"eb line
						color: Color lightGray translucent;
						yourself"
							yourself ]
				layout: [ :shapes | RSClusterLayout on: shapes ] ];
		yourself
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewUsingMondrianBuilder: canvas vertex: sBlock edge: eBlock layout: lBlock [
	| eb shapes |
	"Setting up the nodes"
	shapes := self vertices values
		collect: [ :aVertex | 
			| shape |
			shape := sBlock cull: aVertex.
			shape
				draggable;
				model: aVertex;
				yourself ].
	canvas addAll: shapes shuffled.

	"Setting up the edges"
	eb := eBlock value: RSEdgeBuilder.
	eb
		canvas: canvas;
		shapes: shapes;
		connectToAll: [ :aVertex | aVertex children collect: [ :anEdge | anEdge to ] ].
	lBlock value: shapes.
	"eBlock cull: mondrian shape cull: mondrian edges.
	lBlock value: mondrian layout.
	rtEdges := mondrian edges
		labelElement: [ :rtEdge | rtEdge model weight ifNil: [ String empty ] ];
		source: self edges connectFrom: #from withModelTo: #to.
	mondrian layout layout userDefinedEdges: rtEdges"	"necessary to maintain the insertion order of edges"
	canvas @ RSDraggableCanvas @ RSCanvasController.
	^ canvas
]
