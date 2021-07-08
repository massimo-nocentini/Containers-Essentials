Class {
	#name : #QuoRemMinimal,
	#superclass : #QuoRemStandard,
	#category : #'Containers-Essentials'
}

{ #category : #accessing }
QuoRemMinimal >> initialize [

	| floor ceil r |
	super initialize.

	r := self value.

	floor := r floor.
	ceil := r ceiling.

	quo := r - floor < (ceil - r)
		       ifTrue: [ floor ]
		       ifFalse: [ ceil ].

	rem := a - (quo * b)
]
