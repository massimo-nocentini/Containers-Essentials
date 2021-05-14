Extension { #name : #Integer }

{ #category : #'*Containers-Essentials' }
Integer >> bitBRGC [

	^ self bitXor: self >> 1
]
