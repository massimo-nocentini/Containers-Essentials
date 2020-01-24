Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges [
	^ self edges: nil parent: self
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges: incomingEdges parent: parent [
	| edges |
	edges := parent -> self ~~> incomingEdges.
	^ nextLink
		ifNil: [ edges ]
		ifNotNil: [ :nl | nl edges: edges parent: self ]
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal2
		title: 'Links';
		initializeView: [ RTMondrian new ];
		painting: [ :mondrian | self gtInspectorLinksUsingMondrianBuilder: mondrian ];
		yourself
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> gtInspectorLinksUsingMondrianBuilder: aMondrian [
	self edges asLinkedList asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: [ :vertex | vertex content value ];
				color: Color black ]
		edge: [ :shape | shape arrowedBezier shortestDistanceAttachPointWithJump ]
		layout: #horizontalTree
]
