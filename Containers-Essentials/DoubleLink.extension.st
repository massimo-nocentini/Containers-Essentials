Extension { #name : #DoubleLink }

{ #category : #'*Containers-Essentials' }
DoubleLink >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	value printOn: aStream.
	aStream nextPut: $)
]
