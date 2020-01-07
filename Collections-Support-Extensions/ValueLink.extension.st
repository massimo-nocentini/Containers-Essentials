Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Extensions' }
ValueLink >> asLinkedList [
	^ LinkedList with: self
]
