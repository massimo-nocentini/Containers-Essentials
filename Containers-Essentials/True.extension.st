Extension { #name : #True }

{ #category : #'*Containers-Essentials' }
True >> conditionHandler: handler truthWitness: anObject [

	^ handler cull: anObject
]
