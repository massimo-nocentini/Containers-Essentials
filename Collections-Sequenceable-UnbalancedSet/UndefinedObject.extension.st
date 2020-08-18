Extension { #name : #UndefinedObject }

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
UndefinedObject >> push: anObject witness: aWitness continuation: aContinuation inUnbalancedSet: aSet [
	^ aSet
		  inNilRepresentation: self
		  push: anObject
		  witness: aWitness
		  continuation: aContinuation
]
