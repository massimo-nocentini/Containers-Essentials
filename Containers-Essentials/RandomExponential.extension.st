Extension { #name : #RandomExponential }

{ #category : #'*Containers-Essentials' }
RandomExponential >> densityOfNumber: x [

	^ lambda * (lambda * x) negated exp
]
