Extension { #name : #Number }

{ #category : #'*Containers-Essentials' }
Number >> decrement [
	^ self - 1
]

{ #category : #'*Containers-Essentials' }
Number >> densityExponentialOf: x [

	^ self * (self * x) negated exp
]

{ #category : #'*Containers-Essentials' }
Number >> increment [
	^ self + 1
]
