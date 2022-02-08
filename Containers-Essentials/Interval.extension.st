Extension { #name : #Interval }

{ #category : #'*Containers-Essentials' }
Interval >> linspace: n [

	^ n
		  ifZero: [ self ]
		  ifNotZero: [ start to: stop by: stop - start / n ]
]
