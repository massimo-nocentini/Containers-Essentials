"
I am the greatest common divisor of two integers, with the divisions of Euclid's algorithm that find it, each a `QuoRemMinimal`. `Integer>>#>|<` makes me, with the greater integer as `a` and the other one as `b`.

```smalltalk
| gcd |
gcd := 83 >|< 71.
gcd value. ""1""
gcd equations asArray.
	""{ 83 = 1·71 + 12. 71 = 6·12 - 1. 12 = 12·1 }""
gcd point. ""6 @ -7""
gcd inverseMultiplicativeOfa value
	""'(6 * 83 rem: 71) = 1'""
```

- `value` is the divisor, and as a `Magnitude` I stand for it: I compare with numbers and have the hash of it. My `quo` and `rem` are those of the last division.
- `equations` are the divisions, and `divisibility` those of their dividends by the divisor.
- `point` has the coefficients of `a` and `b` in the linear combination that is the divisor: `6 * 83 + (-7 * 71)` above, which `asStringDiophantineEquation` prints and `asShapeDiophantineEquation` draws with dots.
- `inverseMultiplicativeOfa` and `inverseMultiplicativeOfb` associate the coefficient of `a`, or of `b`, made not negative by adding the other integer, with the equation to print. They are multiplicative inverses when the divisor is 1.
- `solve:ifExists:ifNotExists:` tells whether a linear combination of `a` and `b` is the given integer. If so, the first block takes each coefficient of `point` with its integer, and the divisor, as points; otherwise the second block takes the remainder of the division of that integer by the divisor.
"
Class {
	#name : 'GreatestCommonDivisor',
	#superclass : 'QuoRemComplementary',
	#instVars : [
		'equations',
		'point'
	],
	#category : 'Containers-Essentials-Numbers',
	#package : 'Containers-Essentials',
	#tag : 'Numbers'
}

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitGreatestCommonDivisor: self
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> asShapeDiophantineEquation [

	| r s shapes lines |
	self point x negative
		ifTrue: [ 
			r := self point y * self b.
			s := (self point x * self a) negated.
			lines := self b ]
		ifFalse: [ 
			r := self point x * self a.
			s := (self point y * self b) negated.
			lines := self a ].

	shapes := (1 to: r) collect: [ :each | 
		          RSCircle new
			          withBorder;
			          color: Color white;
			          yourself ].

	(1 to: s) do: [ :i | (shapes at: i) sameColorAsBorderColor ].

	RSGridLayout on: shapes withLineItemsCount: lines.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> asShapeDividendOverGCD [

	^ self a /% self value
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> asShapeDivisorOverGCD [

	^ self b /% self value
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> asStringDiophantineEquation [

	| ax by comb |
	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point x)
		      selector: (OCSelectorNode value: #*)
		      arguments: { (RBLiteralValueNode value: self a) }.

	by := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point y)
		      selector: (OCSelectorNode value: #*)
		      arguments: { (RBLiteralValueNode value: self b) }.

	comb := RBMessageNode receiver: ax selector: (OCSelectorNode value: #+) arguments: { by }.

	^ (RBMessageNode
		   receiver: comb
		   selector: (OCSelectorNode value: #=)
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> divisibility [

	| gcd |
	gcd := self value.

	^ equations collect: [ :each | each a /% gcd ]
]

{ #category : 'accessing' }
GreatestCommonDivisor >> equations [

	^ equations
]

{ #category : 'accessing' }
GreatestCommonDivisor >> initialize [

	| eq quoRemClass |
	quoRemClass := QuoRemMinimal.
	eq := quoRemClass a: a b: b.

	equations := OrderedCollection with: eq.

	[ eq rem abs > 0 ] whileTrue: [ 
		eq := quoRemClass a: eq b b: eq rem abs.
		equations add: eq ].

	quo := eq quo.
	rem := eq rem.

	ratio := eq b.

	point := equations size > 1
		         ifTrue: [ 
			         | eqs |
			         eqs := equations allButLast.
			         eqs allButLast
				         foldr: [ :each :aPoint | 
					         | currentPoint |
					         currentPoint := aPoint y * each asPointWithRespectToRem.
					         currentPoint x @ (aPoint x + currentPoint y) ]
				         init: eqs last asPointWithRespectToRem ]
		         ifFalse: [ 0 @ 1 ]
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> inverseMultiplicativeOf: a_b mul: j rem: mod [

	| ax by i |
	i := j.
	[ i negative ] whileTrue: [ i := i + mod ].

	ax := RBMessageNode
		      receiver: (RBLiteralValueNode value: i)
		      selector: (OCSelectorNode value: #*)
		      arguments: { (RBLiteralValueNode value: a_b) }.

	by := RBMessageNode
		      receiver: ax
		      selector: (OCSelectorNode value: #rem:)
		      arguments: { (RBLiteralValueNode value: mod) }.

	^ i -> (RBMessageNode
		   receiver: by
		   selector: (OCSelectorNode value: #=)
		   arguments: { (RBLiteralValueNode value: self value) })
		  formattedCode
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> inverseMultiplicativeOfa [

	^ self inverseMultiplicativeOf: self a mul: self point x rem: self b
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> inverseMultiplicativeOfb [

	^ self inverseMultiplicativeOf: self b mul: self point y rem: self a
]

{ #category : 'accessing' }
GreatestCommonDivisor >> point [

	^ point
]

{ #category : 'printing' }
GreatestCommonDivisor >> printOn: aStream [

	| by |
	by := RBMessageNode
		      receiver: (RBLiteralValueNode value: self a)
		      selector: (OCSelectorNode value: #gcd:)
		      arguments: { (RBLiteralValueNode value: self b) }.

	aStream nextPutAll: (RBMessageNode
			 receiver: by
			 selector: (OCSelectorNode value: #=)
			 arguments: { (RBLiteralValueNode value: self value) })
			formattedCode
]

{ #category : 'as yet unclassified' }
GreatestCommonDivisor >> solve: c ifExists: eBlock ifNotExists: neBlock [

	| gcd |
	gcd := self value.

	^ (c rem: gcd)
		  ifZero: [ 
			  eBlock
				  value: point x @ self a
				  value: point y @ self b
				  value: gcd asPoint ]
		  ifNotZero: neBlock
]
