Extension { #name : #Graph }

{ #category : #'*Collections-Unordered-Graph-Roassal2' }
Graph >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal2
		title: 'Graph';
		initializeView: [ RTMondrian new ];
		painting:
				[ :mondrian | self gtInspectorGraphViewUsingMondrianBuilder: mondrian ];
		yourself
]

{ #category : #'*Collections-Unordered-Graph-Roassal2' }
Graph >> gtInspectorGraphViewUsingMondrianBuilder: mondrian [
	mondrian shape text
		text: #content;
		color: Color black.
	mondrian nodes: self vertices values.
	mondrian shape arrowedBezier shortestDistanceAttachPointWithJump.
	mondrian edges
		labelElement: [ :rtEdge | rtEdge model weight ifNil: [ String empty ] ];
		source: self edges connectFrom: #from withModelTo: #to.
	mondrian layout tree
]
