Extension { #name : #Random }

{ #category : #'*Containers-Essentials' }
Random >> density: x [

	^ 1 + (RandomGaussian new
		   sigma: Float epsilon;
		   next)
]
