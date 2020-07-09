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
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ 
			  self edges asLinkedList asTree
				  gtInspectorGraphViewIn: RSCanvas new
				  vertexBlock: [ :aVertex | 
					  | text |
					  text := aVertex content
						          ifNil: [ String empty ]
						          ifNotNil: #printStringWithSubscriptRank.
					  RSLabel new
						  text: text;
						  color: Color black;
						  yourself ] ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> printStringWithSubscriptRank [
	self subclassResponsibility
]
