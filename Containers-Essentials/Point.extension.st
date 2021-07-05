Extension { #name : #Point }

{ #category : #'*Containers-Essentials' }
Point >> distanceToOrigin [

	^ self distanceTo: 0 @ 0
]
