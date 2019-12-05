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
	mondrian shape text text: #content.
	mondrian nodes: self vertices.
	mondrian shape arrowedBezier shortestDistanceAttachPointWithJump.
	mondrian edges source: self edges connectFrom: #from to: #to.
	mondrian layout tree
]
