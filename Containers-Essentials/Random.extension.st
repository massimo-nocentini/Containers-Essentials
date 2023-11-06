Extension { #name : 'Random' }

{ #category : '*Containers-Essentials' }
Random >> density: x [

	^ 1 + (RandomGaussian new
		   sigma: Float machineEpsilon;
		   next)
]

{ #category : '*Containers-Essentials' }
Random >> fairCoin [

	^ (RandomBernoulli seed: seed)
		  p: 0.5;
		  yourself
]
