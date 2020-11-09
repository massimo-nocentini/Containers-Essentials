Extension { #name : #LeftistHeapNode }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapNode >> edges: edges parent: aNode [
	| leftEdges rightEdges |
	rightEdges := nextLink edges: edges parent: self.
	leftEdges := previousLink edges: rightEdges parent: self.
	^ ValueLink new
		  value: aNode -> self;
		  nextLink: leftEdges;
		  yourself
]
