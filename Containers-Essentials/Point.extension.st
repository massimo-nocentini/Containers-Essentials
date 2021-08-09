Extension { #name : #Point }

{ #category : #'*Containers-Essentials' }
Point >> distanceToOrigin [

	^ self distanceTo: 0 @ 0
]

{ #category : #'*Containers-Essentials' }
Point >> π [

	^ (self angle / Float pi) asFraction
]
