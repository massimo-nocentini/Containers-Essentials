Extension { #name : #False }

{ #category : #'*Containers-Essentials' }
False >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	^ aReceiver
		  slowExplicitFibonacci: anInteger
		  tail: anotherInteger
		  greaterThanZeroIsFalse: self
]
