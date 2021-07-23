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
Fraction >> kissingFractionLink: aLink [

	^ self ~~> aLink
]

{ #category : #'*Containers-Essentials' }
Fraction >> kissingFractions [

	| kissedFractions vl |
	kissedFractions := Set new.

	vl := ValueLink new
		      value: self asFractionWrtFloor;
		      yourself.

	[ vl ] whileNotNil: [ 
		| gcd diophantinePoint next less aFraction |
		aFraction := vl value.
		kissedFractions add: aFraction.

		gcd := aFraction numerator >|< aFraction denominator.
		diophantinePoint := gcd point.
		next := diophantinePoint x / diophantinePoint y negated.

		less := aFraction numerator - next numerator
		        / (aFraction denominator - next denominator).

		vl := next kissingFractionLink:
			      (less kissingFractionLink: vl nextLink) ].

	^ kissedFractions asArray
		  sort;
		  yourself
]

{ #category : #'*Containers-Essentials' }
Fraction >> mediantFraction: aFraction [

	^ aFraction numerator + self numerator
	  / (aFraction denominator + self denominator)
]

{ #category : #'*Containers-Essentials' }
Fraction >> mediantInteger: anInteger [

	^ self numerator + anInteger numerator
	  / (self denominator + anInteger denominator)
]
