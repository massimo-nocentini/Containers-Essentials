Extension { #name : #ArrayedCollection }

{ #category : #'*Collections-Sequenceable-LeftistHeap' }
ArrayedCollection >> asLeftishHeap [
	^ LeftistHeap forArrayedCollection: self
]
