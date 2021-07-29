Extension { #name : #Random }

{ #category : #'*Containers-Essentials' }
Random >> densityOfNumber: x [

	^ 1 - Float epsilon + (RandomGaussian new
		   sigma: 1e-8;
		   next)
]
