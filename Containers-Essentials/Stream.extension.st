Extension { #name : 'Stream' }

{ #category : '*Containers-Essentials' }
Stream >> nextPut: anObject inversion: invObject [

	^ self nextPut: anObject -> invObject
]
