Extension { #name : #Integer }

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
Integer >> nextOfLink: aLink [

	^ aLink nextInteger: self
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
