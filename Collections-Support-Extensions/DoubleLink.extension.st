Extension { #name : #DoubleLink }

{ #category : #'*Collections-Support-Extensions' }
DoubleLink >> printOn: aStream [
	aStream nextPutAll: 'a DoubleLink('.
	value printOn: aStream.
	aStream nextPut: $)
]
