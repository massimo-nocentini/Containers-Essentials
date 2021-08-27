Extension { #name : #RandomExponential }

{ #category : #'*Containers-Essentials' }
RandomExponential >> density: x [

	^ lambda * (lambda * x) negated exp
]
