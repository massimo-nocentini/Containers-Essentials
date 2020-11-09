Extension { #name : #LeftistHeapEmpty }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeapEmpty >> edges: aLink parent: parent [
	^ ValueLink new
		  value: parent -> self;
		  nextLink: aLink;
		  yourself
]
