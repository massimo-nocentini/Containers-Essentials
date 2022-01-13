Extension { #name : #Boolean }

{ #category : #'*Containers-Essentials' }
Boolean >> isBoolean [

	^ true
]

{ #category : #'*Containers-Essentials' }
Boolean >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	self subclassResponsibility
]
