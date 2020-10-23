Extension { #name : #DoubleLink }

{ #category : #'*Collections-Support-Extensions' }
DoubleLink >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	value printOn: aStream.
	aStream nextPut: $)
]
