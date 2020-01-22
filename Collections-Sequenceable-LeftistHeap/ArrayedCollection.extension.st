Extension { #name : #ArrayedCollection }

{ #category : #'*Collections-Sequenceable-LeftistHeap' }
ArrayedCollection >> asLeftishHeap [
	^ LeftistHeap forArrayedCollection: self from: 1 to: self size
]
