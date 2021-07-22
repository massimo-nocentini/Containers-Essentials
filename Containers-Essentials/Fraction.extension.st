Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials' }
Fraction >> \/ anObject [

	^ anObject mediantFraction: self
]

{ #category : #'*Containers-Essentials' }
Fraction >> asFractionWrtFloor [

	^ self - self floor
]

{ #category : #'*Containers-Essentials' }
Fraction >> asPointIntegerBounds [

	^ self floor @ self ceiling
]

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

{ #category : #'*Containers-Essentials' }
Fraction >> fordRadius [

	^ denominator squared double reciprocal
]

{ #category : #'*Containers-Essentials' }
Fraction >> kissingFractions [

	| reduced kissedFractions |
	reduced := self asFractionWrtFloor.

	kissedFractions := SortedCollection new.

	[ reduced denominator = 1 ] whileFalse: [ 
		| gcd diophantinePoint next less |
		kissedFractions add: reduced.
		gcd := reduced numerator >|< reduced denominator.
		diophantinePoint := gcd point.
		next := diophantinePoint x / diophantinePoint y negated.

		less := reduced numerator - next numerator
		        / (reduced denominator - next denominator).
		kissedFractions add: less.

		reduced := next ].

	^ kissedFractions"
		  add: reduced;
		  yourself"
]

{ #category : #'*Containers-Essentials' }
Fraction >> mediantFraction: aFraction [

	^ aFraction numerator + self numerator
	  / (aFraction denominator + self denominator)
]
