Extension { #name : #Point }

{ #category : #'*Containers-Essentials' }
Point >> catalanTriangle [
	^ Array2D
		rows: self x
		columns: self y
		tabulate: [ :n :k | n - 1 catalan: k - 1 ]
]

{ #category : #'*Containers-Essentials' }
Point >> distanceToOrigin [

	^ self distanceTo: 0 @ 0
]

{ #category : #'*Containers-Essentials' }
Point >> pascalTriangle [
	^ Array2D
		rows: self x
		columns: self y
		tabulate: [ :n :k | n - 1 choose: k - 1 ]
]

{ #category : #'*Containers-Essentials' }
Point >> π [

	^ (self angle / Float π) asFraction
		  ifNegative: [ :radians | radians + 2 ]
		  ifNotNegative: [ :radians | radians ]
]
