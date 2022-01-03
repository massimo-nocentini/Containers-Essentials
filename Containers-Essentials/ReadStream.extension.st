Extension { #name : #ReadStream }

{ #category : #'*Containers-Essentials' }
ReadStream >> sizeUpToEnd [

	^ readLimit - position
]
