Extension { #name : #Number }

{ #category : #'*Containers-Essentials' }
Number >> densityExponentialOf: x [

	^ self * (self * x) negated exp
]
