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
LeftistHeap >> gtInspectorTreeUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  | text |
			  text := aVertex content
				          ifNil: [ String empty ]
				          ifNotNil: #printStringWithSubscriptRank.
			  RSLabel new
				  text: text;
				  color: Color black;
				  yourself ]
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ self gtInspectorTreeUsingCanvas: RSCanvas new ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> printStringWithSubscriptRank [
	self subclassResponsibility
]
