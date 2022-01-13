Extension { #name : #True }

{ #category : #'*Containers-Essentials' }
True >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	^ aReceiver
		  slowExplicitFibonacci: anInteger
		  tail: anotherInteger
		  greaterThanZeroIsTrue: self
]
