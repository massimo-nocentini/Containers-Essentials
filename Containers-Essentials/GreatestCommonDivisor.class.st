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
		      selector: #*
		      arguments: { (RBLiteralValueNode value: self a) }.

	by := RBMessageNode
		      receiver: (RBLiteralValueNode value: self point y)
		      selector: #*
		      arguments: { (RBLiteralValueNode value: self b) }.

	comb := RBMessageNode receiver: ax selector: #+ arguments: { by }.

	^ (RBMessageNode
		   receiver: comb
		   selector: #=
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
		      selector: #*
		      arguments: { (RBLiteralValueNode value: a_b) }.

	by := RBMessageNode
		      receiver: ax
		      selector: #rem:
		      arguments: { (RBLiteralValueNode value: mod) }.

	^ i -> (RBMessageNode
		   receiver: by
		   selector: #=
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
		      selector: #gcd:
		      arguments: { (RBLiteralValueNode value: self b) }.

	aStream nextPutAll: (RBMessageNode
			 receiver: by
			 selector: #=
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
