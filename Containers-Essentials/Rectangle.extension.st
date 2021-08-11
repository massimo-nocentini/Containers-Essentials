Extension { #name : #Rectangle }

{ #category : #'*Containers-Essentials' }
Rectangle class >> emptyAtOrigin [
	^ self origin: 0 asPoint extent: 0 asPoint
]
