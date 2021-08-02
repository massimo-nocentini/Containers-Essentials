Extension { #name : #Random }

{ #category : #'*Containers-Essentials' }
Random >> densityOfNumber: x [

	^ 1 + (RandomGaussian new
		   sigma: Float epsilon;
		   next)
]
