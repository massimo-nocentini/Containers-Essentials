Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials' }
Fraction >> asPointOnUnitCircle [

	| u v squared d |
	squared := self squared.
	d := 1 + squared.

	u := -2 * self / d.
	v := 1 - squared / d.

	^ u @ v
]

{ #category : #'*Containers-Essentials' }
Fraction >> asPythagoreanTriple [

	| unitPoint |
	unitPoint := self asPointOnUnitCircle.

	^ Array
		  with: unitPoint x numerator
		  with: unitPoint y numerator
		  with: unitPoint x denominator
]
