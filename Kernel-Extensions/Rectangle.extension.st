Extension { #name : #Rectangle }

{ #category : #'*Kernel-Extensions' }
Rectangle class >> emptyAtOrigin [
	^ self origin: 0 asPoint extent: 0 asPoint
]
