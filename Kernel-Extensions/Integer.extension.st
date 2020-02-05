Extension { #name : #Integer }

{ #category : #'*Kernel-Extensions' }
Integer >> eightBits [
	| byte |
	byte := self bitAnd: 16rff.
	^ ((0 to: 7) collect: [ :i | (1 << i bitAnd: byte) >> i ]) reversed
]

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
Integer >> skewBinaryCanonicalDenseRepresentation [
	^ SkewBinaryCanonicalNumber denseRepresentationOfInteger: self
]
