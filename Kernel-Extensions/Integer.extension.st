Extension { #name : #Integer }

{ #category : #'*Kernel-Extensions' }
Integer >> ifNotZero: nzBlock [
	^ self ifZero: #yourself ifNotZero: nzBlock
]

{ #category : #'*Kernel-Extensions' }
Integer >> ifZero: zBlock [
	^ self ifZero: zBlock ifNotZero: #yourself
]

{ #category : #'*Kernel-Extensions' }
Integer >> ifZero: zBlock ifNotZero: nzBlock [
	^ self = 0
		ifTrue: [ zBlock cull: self ]
		ifFalse: [ nzBlock cull: self ]
]

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
