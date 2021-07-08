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
Number >> increment [
	^ self + 1
]
