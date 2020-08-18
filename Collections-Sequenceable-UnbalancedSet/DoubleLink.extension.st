Extension { #name : #DoubleLink }

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
DoubleLink >> includes: anObject witness: aWitness inUnbalancedSet: aSet [

	^ aSet
		  inDoubleLinkRepresentation: self
		  includes: anObject
		  witness: aWitness
]

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
DoubleLink >> push: anObject witness: aWitness continuation: aContinuation inUnbalancedSet: aSet [
	^ aSet
		  inDoubleLinkRepresentation: self
		  push: anObject
		  witness: aWitness
		  continuation: aContinuation
]
