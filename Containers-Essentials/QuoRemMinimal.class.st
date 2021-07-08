Class {
	#name : #QuoRemMinimal,
	#superclass : #QuoRemComplementary,
	#category : #'Containers-Essentials'
}

{ #category : #converting }
QuoRemMinimal >> asShapeDots [

	| shapes absRem |
	absRem := rem ifNegative: [ 0 ] ifZero: [ 0 ] ifPositive: #yourself.

	shapes := (1 to: b * quo + absRem) collect: [ :each | 
		          RSCircle new
			          withBorder;
			          color: Color white;
			          yourself ].

	rem
		ifNegative: [ 
			(1 to: rem negated) do: [ :i | 
				(shapes at: shapes size + (1 - i)) sameColorAsBorderColor ] ]
		ifZero: [  ]
		ifPositive: [  ].

	RSGridLayout on: shapes withLineItemsCount: b.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

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

{ #category : #converting }
QuoRemMinimal >> numberOfDots [

	| absRem |
	absRem := rem ifNegative: [ 0 ] ifZero: [ 0 ] ifPositive: #yourself.

	^ super numberOfDots + absRem
]
