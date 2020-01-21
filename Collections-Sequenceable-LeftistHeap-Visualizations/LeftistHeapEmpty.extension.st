Extension { #name : #LeftistHeapEmpty }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapEmpty >> edges [
	^ self edges: nil parentHeapNode: self
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapEmpty >> edges: outerEdges parentHeapNode: aNode [
	^ ValueLink new
		value: aNode -> self;
		nextLink: outerEdges;
		yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapEmpty >> printStringWithSubscriptRank [
	^ String
		streamContents: [ :s | 
			s
				nextPut: $•;
				nextPut: $₍;
				nextPutAll: rank printSubscriptString;
				nextPut: $₎ ]
]
