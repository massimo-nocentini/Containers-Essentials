Extension { #name : #Number }

{ #category : #'*Containers-Essentials' }
Number >> decrement [
	^ self - 1
]

{ #category : #'*Containers-Essentials' }
Number >> density: aRandom [

	^ aRandom densityOfNumber: self
]

{ #category : #'*Containers-Essentials' }
Number >> ifNegative: nBlock [

	^ self ifNegative: nBlock ifZero: [ self ] ifPositive: [ self ]
]

{ #category : #'*Containers-Essentials' }
Number >> ifNegative: nBlock ifNotNegative: nnBlock [

	^ self ifNegative: nBlock ifZero: nnBlock ifPositive: nnBlock
]

{ #category : #'*Containers-Essentials' }
Number >> ifNegative: nBlock ifZero: zBlock ifPositive: pBlock [

	| block |
	block := self negative
		         ifTrue: [ nBlock ]
		         ifFalse: [ 
			         self isZero
				         ifTrue: [ zBlock ]
				         ifFalse: [ pBlock ] ].

	^ block cull: self
]

{ #category : #'*Containers-Essentials' }
Number >> ifPositive: pBlock [

	^ self ifNegative: [ self ] ifZero: [ self ] ifPositive: pBlock
]

{ #category : #'*Containers-Essentials' }
Number >> ifPositive: pBlock ifNotPositive: npBlock [

	^ self ifNegative: npBlock ifZero: npBlock ifPositive: pBlock
]

{ #category : #'*Containers-Essentials' }
Number >> increment [
	^ self + 1
]
