Extension { #name : #Graph }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal2
		title: 'Graph';
		initializeView: [ RTMondrian new ];
		painting: [ :mondrian | 
			self
				gtInspectorGraphViewUsingMondrianBuilder: mondrian
				vertex: [ :shape | 
					shape text
						text: #content;
						color: Color black ]
				edge: [ :shape | shape arrowedBezier shortestDistanceAttachPointWithJump ]
				layout: #tree ];
		yourself
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
Graph >> gtInspectorGraphViewUsingMondrianBuilder: mondrian vertex: sBlock edge: eBlock layout: lBlock [
	| rtEdges |
	sBlock value: mondrian shape.
	mondrian nodes: self vertices values.
	eBlock cull: mondrian shape cull: mondrian edges.
	lBlock value: mondrian layout.
	rtEdges := mondrian edges
		labelElement: [ :rtEdge | rtEdge model weight ifNil: [ String empty ] ];
		source: self edges connectFrom: #from withModelTo: #to.
	mondrian layout layout userDefinedEdges: rtEdges	"necessary to maintain the insertion order of edges"
]
