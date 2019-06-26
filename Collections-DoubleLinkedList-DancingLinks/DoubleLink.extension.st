Extension { #name : #DoubleLink }

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLink >> remove [
	nextLink ifNotNil: [ :next | next previousLink: previousLink ].
	previousLink
		ifNotNil: [ :previous | previous nextLink: nextLink ]
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
DoubleLink >> restore [
	nextLink ifNotNil: [ :next | next previousLink: self ].
	previousLink ifNotNil: [ :previous | previous nextLink: self ]
]
