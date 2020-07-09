Extension { #name : #Tree }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Tree >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ 
			  self
				  gtInspectorGraphViewUsingMondrianBuilder: RSCanvas new
				  vertex: [ :aVertex | 
					  RSLabel new
						  text: aVertex content;
						  color: Color black;
						  yourself ]
				  edge: [ :eb | 
					  eb orthoVertical
						  color: Color lightGray translucent;
						  cornerRadii: 5;
						  yourself ]
				  layout: [ :shapes :edgesShapes | 
				  RSTreeLayout on: shapes edges: edgesShapes ] ];
		  yourself
]
