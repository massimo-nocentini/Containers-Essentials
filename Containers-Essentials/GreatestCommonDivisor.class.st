Class {
	#name : #GreatestCommonDivisor,
	#superclass : #QuoRemComplementary,
	#instVars : [
		'equations',
		'point'
	],
	#category : #'Containers-Essentials'
}

{ #category : #'as yet unclassified' }
GreatestCommonDivisor >> divisibility [

	| gcd |
	gcd := self value.

	^ equations collect: [ :each | each a /% gcd ]
]

{ #category : #accessing }
GreatestCommonDivisor >> equations [

	^ equations
]

{ #category : #accessing }
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

	equations size > 1 ifTrue: [ 
		point := equations allButLast allButLast
			         foldr: [ :each :aPoint | 
				         | currentPoint |
				         currentPoint := aPoint y * each asPointWithRespectToRem.
				         currentPoint x @ (aPoint x + currentPoint y) ]
			         init: equations lastButOne asPointWithRespectToRem ]
]

{ #category : #accessing }
GreatestCommonDivisor >> point [

	^ point
]

{ #category : #printing }
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

{ #category : #'as yet unclassified' }
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
