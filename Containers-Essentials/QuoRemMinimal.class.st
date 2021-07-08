Class {
	#name : #QuoRemMinimal,
	#superclass : #QuoRemStandard,
	#category : #'Containers-Essentials'
}

{ #category : #accessing }
QuoRemMinimal >> initialize [

	| ratio floor ceil |
	ratio := self asNumber.

	floor := ratio floor.
	ceil := ratio ceiling.

	quo := ratio - floor < (ceil - ratio)
		       ifTrue: [ floor ]
		       ifFalse: [ ceil ].

	rem := a - (quo * b)
]
