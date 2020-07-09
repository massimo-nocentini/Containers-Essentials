Extension { #name : #LeftistHeapNode }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapNode >> edges [
	^ self edges: nil parentHeapNode: self
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapNode >> edges: outerEdges parentHeapNode: aNode [
	^ ValueLink new
		value: aNode -> self;
		nextLink:
			(previousLink
				edges: (nextLink edges: outerEdges parentHeapNode: self)
				parentHeapNode: self);
		yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapNode >> printStringWithSubscriptRank [
	^ String streamContents: [ :s | 
		  value printOn: s.
		  s
			  nextPut: $₍;
			  nextPutAll: rank asString subscript;
			  nextPut: $₎ ]
]
