Class {
	#name : #GreatestCommonDivisor,
	#superclass : #QuoRemComplementary,
	#instVars : [
		'equations'
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
GreatestCommonDivisor >> initialize [

	| eq quoRemClass |
	quoRemClass := QuoRemStandard.
	eq := quoRemClass a: a b: b.

	equations := OrderedCollection with: eq.

	[ eq rem abs > 0 ] whileTrue: [ 
		eq := quoRemClass a: eq b b: eq rem abs.
		equations add: eq ].

	quo := eq quo.
	rem := eq rem.

	ratio := eq b
]

{ #category : #printing }
GreatestCommonDivisor >> printOn: aStream [

	| node |
	node := RBParser parseExpression: (aStream
			         nextPutAll: '(';
			         nextPutAll: a asString;
			         nextPutAll: ' gcd: ';
			         nextPutAll: b asString;
			         nextPutAll: ') = ';
			         nextPutAll: self value asString) contents.

	^ node formattedCode
]

{ #category : #'as yet unclassified' }
GreatestCommonDivisor >> solve: c ifExists: eBlock ifNotExists: neBlock [

	| gcd |
	gcd := self value.

	^ (c rem: gcd)
		  ifZero: [ 
			  | point |
			  point := equations lastButOne in: [ :eq | 1 @ eq quo negated ].
			  (equations size - 2 to: 1 by: -1) do: [ :i | 
				  | previousEq eq previousPoint |
				  eq := equations at: i + 1.
				  previousEq := equations at: i.

				  previousPoint := 1 @ previousEq quo negated.

				  point := point y * previousPoint in: [ :currentPoint | 
					           currentPoint x @ (point x + currentPoint y) ] ].

			  eBlock value: point x @ self a value: point y @ self b value: gcd ]
		  ifNotZero: neBlock
]
