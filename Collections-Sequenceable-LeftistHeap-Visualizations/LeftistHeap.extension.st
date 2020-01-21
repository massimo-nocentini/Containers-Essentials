Extension { #name : #LeftistHeap }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> edges [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> edges: outerEdges parentHeapNode: aValue [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreeUsingMondrianBuilder: aMondrian [
	self edges asLinkedList asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: [ :vertex | 
					vertex content
						ifNil: [ String empty ]
						ifNotNil: #printStringWithSubscriptRank ];
				color: Color black ]
		edge: [ :shape | shape orthoVerticalLine ]
		layout: #tree
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Tree';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorTreeUsingMondrianBuilder: b ];
		yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> isEmpty [
	self subclassResponsibility
]
