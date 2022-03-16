Extension { #name : #Interval }

{ #category : #'*Containers-Essentials' }
Interval >> linspace: n [

	^ n < 2
		  ifTrue: [ self ]
		  ifFalse: [ start to: stop by: stop - start / (n - 1) ]
]

{ #category : #'*Containers-Essentials' }
Interval >> unitAt: t [

	^ (t min: stop max: start) - start / (stop - start)
]
