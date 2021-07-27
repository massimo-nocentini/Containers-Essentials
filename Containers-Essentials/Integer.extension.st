Extension { #name : #Integer }

{ #category : #'*Containers-Essentials' }
Integer >> /% anObject [

	^ anObject quoRemInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> /%< anObject [

	^ anObject quoRemMinimalInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> /%~ anObject [

	^ anObject quoRemComplementaryInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> >|< anObject [

	^ anObject greatestCommonDisivorInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> \/ anObject [

	^ anObject mediantInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> asDetailedRepresentationsView [

	^ CTIntegerRepresentationsView new
		  integer: self;
		  yourself
]

{ #category : #'*Containers-Essentials' }
Integer >> bitBRGC [

	^ self bitXor: self >> 1
]

{ #category : #'*Containers-Essentials' }
Integer >> fibonacciNumbers [

	^ self gibonacciNumbersFirst: 0 second: 1 do: [ :a :b | a + b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> gibonacciNumbersFirst: first second: second do: aBlock [

	^ self
		  ifPositive: [ 
			  Array streamContents: [ :aStream | 
				  | a |
				  a := first.
				  aStream nextPut: a.
				  self > 1 ifTrue: [ 
					  | b |
					  b := second.
					  aStream nextPut: b.
					  3 to: self do: [ :each | 
						  | c v |
						  c := aBlock value: a value: b.
						  aStream nextPut: c.
						  a := b.
						  b := c ] ] ] ]
		  ifNotPositive: [ #(  ) ]
]

{ #category : #'*Containers-Essentials' }
Integer >> greatestCommonDisivorInteger: anInteger [

	| max min |
	max := self max: anInteger.
	min := self min: anInteger.

	^ GreatestCommonDivisor a: max b: min
]

{ #category : #'*Containers-Essentials' }
Integer >> ifZero: zBlock ifOne: oBlock ifTwo: tBlock otherwise: eBlock [

	^ self = 0
		  ifTrue: zBlock
		  ifFalse: [ 
			  self = 1
				  ifTrue: oBlock
				  ifFalse: [ 
					  self = 2
						  ifTrue: tBlock
						  ifFalse: eBlock ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> kissingFractionLink: aLink [

	^ aLink
]

{ #category : #'*Containers-Essentials' }
Integer >> lucasNumbers [

	^ self gibonacciNumbersFirst: 2 second: 1 do: [ :a :b | a + b ]
]

{ #category : #'*Containers-Essentials' }
Integer >> mediantFraction: aFraction [

	^ aFraction numerator + self / (aFraction denominator + self)
]

{ #category : #'*Containers-Essentials' }
Integer >> mediantInteger: anInteger [

	^ self + anInteger / 2
]

{ #category : #'*Containers-Essentials' }
Integer >> nextOfLink: aLink [

	^ aLink nextInteger: self
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemComplementaryInteger: anInteger [

	^ QuoRemComplementary a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemInteger: anInteger [

	^ QuoRemStandard a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> quoRemMinimalInteger: anInteger [

	^ QuoRemMinimal a: anInteger b: self
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalDenseRepresentation [
	^ self isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
		  (self skewBinaryCanonicalDenseRepresentationWeight: 1) second ]
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalDenseRepresentationWeight: w [
	^ self < w
		  ifTrue: [ Array with: self with: nil ]
		  ifFalse: [ 
			  | rest tuple wDoubled recursiveRepresentation |
			  wDoubled := w * 2.
			  tuple := self skewBinaryCanonicalDenseRepresentationWeight:
				           wDoubled + 1.
			  rest := tuple first.
			  recursiveRepresentation := tuple second.
			  wDoubled = rest
				  ifTrue: [ Array with: 0 with: 2 ~~> recursiveRepresentation ]
				  ifFalse: [ 
					  w <= rest
						  ifTrue: [ 
						  Array with: rest - w with: 1 ~~> recursiveRepresentation ]
						  ifFalse: [ 
						  Array with: rest with: 0 ~~> recursiveRepresentation ] ] ]
]

{ #category : #'*Containers-Essentials' }
Integer >> skewBinaryCanonicalSparseRepresentation [
	^ self isZero
		  ifTrue: [ '•' ~~> nil ]
		  ifFalse: [ 
			  | skew |
			  skew := SkewBinaryCanonicalNumber new.
			  self timesRepeat: [ skew := skew increment ].
			  skew representation ]
]
