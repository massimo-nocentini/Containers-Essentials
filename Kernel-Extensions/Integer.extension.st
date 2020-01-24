Extension { #name : #Integer }

{ #category : #'*Kernel-Extensions' }
Integer >> printSubscriptString [
	| subscripts |
	subscripts := Object subscripts.
	^ self printString collect: [ :each | subscripts at: each ]
]

{ #category : #'*Kernel-Extensions' }
Integer >> skewBinaryCanonicalDenseRepresentation [
	^ SkewBinaryCanonicalNumber denseRepresentationOfInteger: self
]
