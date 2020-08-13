Extension { #name : #Integer }

{ #category : #'*Kernel-Extensions' }
Integer >> bitInvert8 [
	"Answer the 8-bit complement of the receiver."

	| mask |
	mask := 16rFF.
	^ (self bitAnd: mask) bitXor: mask
]

{ #category : #'*Kernel-Extensions' }
Integer >> catalan [
	^ (2 * self choose: self) / (self + 1)
]

{ #category : #'*Kernel-Extensions' }
Integer >> catalan: k [
	^ (2 * self - k choose: self - k)
		- (2 * self - k choose: self - k - 1)
]

{ #category : #'*Kernel-Extensions' }
Integer >> choose: k [
	^ (k positive and: [ self >= k ])
		ifTrue: [ self factorial / (k factorial * (self - k) factorial) ]
		ifFalse: [ 0 ]
]

{ #category : #'*Kernel-Extensions' }
Integer >> decrease [
	^  self - 1
]

{ #category : #'*Kernel-Extensions' }
Integer >> double [
	^ 2 * self
]

{ #category : #'*Kernel-Extensions' }
Integer >> eightBits [
	| byte |
	byte := self bitAnd: 16rff.
	^ (0 to: 7) collect: [ :i | (1 << i bitAnd: byte) ~= 0 ]
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
Integer >> increase [
	^ 1 + self
]

{ #category : #'*Kernel-Extensions' }
Integer >> skewBinaryCanonicalDenseRepresentation [
	^ self isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
		  (self skewBinaryCanonicalDenseRepresentationWeight: 1) second ]
]

{ #category : #'*Kernel-Extensions' }
Integer >> skewBinaryCanonicalDenseRepresentationWeight: w [
	^ self < w
		  ifTrue: [ Array with: self with: nil ]
		  ifFalse: [ 
			  | rest tuple wDoubled recursiveRepresentation |
			  wDoubled := w * 2.
			  tuple := self skewBinaryCanonicalDenseRepresentationWeight:
				           wDoubled + 1.
			  rest := tuple first.
			  recursiveRepresentation := tuple second.
			  wDoubled = rest
				  ifTrue: [ Array with: 0 with: 2 ~~> recursiveRepresentation ]
				  ifFalse: [ 
					  w <= rest
						  ifTrue: [ 
						  Array with: rest - w with: 1 ~~> recursiveRepresentation ]
						  ifFalse: [ 
						  Array with: rest with: 0 ~~> recursiveRepresentation ] ] ]
]

{ #category : #'*Kernel-Extensions' }
Integer >> skewBinaryCanonicalSparseRepresentation [
	^ self isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
			  | skew |
			  skew := SkewBinaryCanonicalNumber new.
			  self timesRepeat: [ skew := skew increment ].
			  skew representation ]
]
