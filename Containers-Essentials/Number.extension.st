Extension { #name : 'Number' }

{ #category : '*Containers-Essentials' }
Number >> adaptToComplex: rcvr andSend: selector [

	"If I am involved in arithmetic with a Complex number, convert me to a Complex number."

	^ rcvr perform: selector with: self asComplex
]

{ #category : '*Containers-Essentials' }
Number >> addNumber: aNumber [

	^ self + aNumber
]

{ #category : '*Containers-Essentials' }
Number >> arcCosh [
	"Answer receiver's area hyperbolic cosine.
	That is the inverse function of cosh."

	^self asFloat arcCosh
]

{ #category : '*Containers-Essentials' }
Number >> arcSinh [
	"Answer receiver's area hyperbolic cosine.
	That is the inverse function of cosh."

	^self asFloat arcSinh
]

{ #category : '*Containers-Essentials' }
Number >> arcTanh [
	
	^self asFloat arcTanh 
]

{ #category : '*Containers-Essentials' }
Number >> asComplex [

	"Answer a Complex number that represents value of the the receiver."

	^ Complex real: self imaginary: 0
]

{ #category : '*Containers-Essentials' }
Number >> cosh [
	
	^self asFloat cosh
]

{ #category : '*Containers-Essentials' }
Number >> decrement [
	^ self - 1
]

{ #category : '*Containers-Essentials' }
Number >> double [

	^ self * 2
]

{ #category : '*Containers-Essentials' }
Number >> i [

	^ Complex real: 0 imaginary: self
]

{ #category : '*Containers-Essentials' }
Number >> ifNegative: nBlock [

	^ self ifNegative: nBlock ifZero: [ self ] ifPositive: [ self ]
]

{ #category : '*Containers-Essentials' }
Number >> ifNegative: nBlock ifNotNegative: nnBlock [

	^ self ifNegative: nBlock ifZero: nnBlock ifPositive: nnBlock
]

{ #category : '*Containers-Essentials' }
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

{ #category : '*Containers-Essentials' }
Number >> ifPositive: pBlock [

	^ self ifNegative: [ self ] ifZero: [ self ] ifPositive: pBlock
]

{ #category : '*Containers-Essentials' }
Number >> ifPositive: pBlock ifNotPositive: npBlock [

	^ self ifNegative: npBlock ifZero: npBlock ifPositive: pBlock
]

{ #category : '*Containers-Essentials' }
Number >> increment [
	^ self + 1
]

{ #category : '*Containers-Essentials' }
Number >> isTo: x as: y isTo: aBlock [

	^ aBlock value: y * x / self
]

{ #category : '*Containers-Essentials' }
Number >> multiplyNumber: aNumber [

	^ self * aNumber
]

{ #category : '*Containers-Essentials' }
Number >> relativeError: anApproximation [

	^ anApproximation - self / self
]

{ #category : '*Containers-Essentials' }
Number >> sinh [
	
	^self asFloat sinh
]

{ #category : '*Containers-Essentials' }
Number >> subtractNumber: aNumber [

	^ self - aNumber
]

{ #category : '*Containers-Essentials' }
Number >> tanh [

	^ self asFloat tanh
]

{ #category : '*Containers-Essentials' }
Number >> to: end splitAt: split beforeDo: bBlock afterDo: aBlock [
	1 to: split do: bBlock.
	split + 1 to: end do: aBlock
]

{ #category : '*Containers-Essentials' }
Number >> triple [

	^ self * 3
]
