Extension { #name : #DoubleLink }

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
DoubleLink >> push: anObject witness: aWitness continuation: aContinuation inUnbalancedSet: aSet [
	^ aSet
		  inDoubleLinkRepresentation: self
		  push: anObject
		  witness: aWitness
		  continuation: aContinuation
]
