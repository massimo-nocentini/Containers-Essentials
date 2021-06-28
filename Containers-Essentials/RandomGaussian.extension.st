Extension { #name : #RandomGaussian }

{ #category : #'*Containers-Essentials' }
RandomGaussian >> densityOfNumber: x [

	^ densityMultiplier * ((x - mu / sigma) squared negated / 2) exp
]
