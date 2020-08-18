Extension { #name : #UndefinedObject }

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
UndefinedObject >> includes: anObject witness: aWitness inUnbalancedSet: aSet [

	^ aSet inNilRepresentation: self includes: anObject witness: aWitness
]

{ #category : #'*Collections-Sequenceable-UnbalancedSet' }
UndefinedObject >> push: anObject witness: aWitness continuation: aContinuation inUnbalancedSet: aSet [
	^ aSet
		  inNilRepresentation: self
		  push: anObject
		  witness: aWitness
		  continuation: aContinuation
]
