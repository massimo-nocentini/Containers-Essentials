Extension { #name : #Tree }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Tree >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ 
			  self
				  gtInspectorGraphViewIn: RSCanvas new
				  vertexBlock: [ :aVertex | 
					  RSLabel new
						  text: aVertex content;
						  color: Color black;
						  yourself ]
				  edgeBlock: [ :eb | 
					  eb orthoVertical
						  color: Color lightGray translucent;
						  cornerRadii: 5;
						  yourself ] ];
		  yourself
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Tree >> gtInspectorGraphViewIn: canvas vertexBlock: vBlock [
	^ self
		  gtInspectorGraphViewUsingMondrianBuilder: canvas
		  vertex: vBlock
		  edge: [ :eb | 
			  | line |
			  line := RSPolyline new
				          cornerRadii: 5;
				          markerEnd: RSArrowedLine new defaultHead asMarker;
				          yourself.
			  (eb horizontalLine: line)
				  withHorizontalAttachPoint;
				  color: Color gray;
				  cornerRadii: 5;
				  yourself ]
		  layout: [ :shapes :edgesShapes | 
			  RSHorizontalTreeLayout on: shapes edges: edgesShapes ]
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Tree >> gtInspectorGraphViewIn: canvas vertexBlock: vBlock edgeBlock: eBlock [
	^ self
		  gtInspectorGraphViewUsingMondrianBuilder: canvas
		  vertex: vBlock
		  edge: eBlock
		  layout: [ :shapes :edgesShapes | 
		  RSTreeLayout on: shapes edges: edgesShapes ]
]
