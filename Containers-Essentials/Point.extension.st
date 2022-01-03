Extension { #name : #Point }

{ #category : #'*Containers-Essentials' }
Point >> distanceToOrigin [

	^ self distanceTo: 0 @ 0
]

{ #category : #'*Containers-Essentials' }
Point >> xMinusY [

	^ self x - self y
]

{ #category : #'*Containers-Essentials' }
Point >> yMinusX [

	^ self y - self x
]

{ #category : #'*Containers-Essentials' }
Point >> π [

	^ (self angle / Float π) asFraction
		  ifNegative: [ :radians | radians + 2 ]
		  ifNotNegative: [ :radians | radians ]
]
