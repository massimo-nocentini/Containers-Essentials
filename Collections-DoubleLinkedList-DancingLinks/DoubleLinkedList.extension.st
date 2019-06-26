Extension { #name : #DoubleLinkedList }

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLinkedList >> makeCircular [
	head previousLink: tail.
	tail nextLink: head
]
