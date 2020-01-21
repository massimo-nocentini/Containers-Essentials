Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Sequenceable-LeftistHeap' }
SequenceableCollection >> asLeftishHeap [
	^ LeftistHeap fromSequenceableCollection: self
]
