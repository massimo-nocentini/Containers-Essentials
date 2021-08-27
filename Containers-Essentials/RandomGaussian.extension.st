Extension { #name : #RandomGaussian }

{ #category : #'*Containers-Essentials' }
RandomGaussian >> density: x [

	^ densityMultiplier * ((x - mu / sigma) squared negated / 2) exp
]
