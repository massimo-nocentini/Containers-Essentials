Class {
	#name : #GreatestCommonDivisor,
	#superclass : #QuoRemComplementary,
	#instVars : [
		'equations'
	],
	#category : #'Containers-Essentials'
}

{ #category : #accessing }
GreatestCommonDivisor >> asShapeDividendOverGCD [

	^ (self a /% self value) asShapeSlotsDfsTree
]

{ #category : #accessing }
GreatestCommonDivisor >> asShapeDivisorOverGCD [

	^ (self b /% self value) asShapeSlotsDfsTree
]

{ #category : #accessing }
GreatestCommonDivisor >> initialize [

	| eq |
	eq := QuoRemStandard a: a b: b.

	equations := OrderedCollection with: eq.

	[ eq rem > 0 ] whileTrue: [ 
		eq := QuoRemStandard a: eq b b: eq rem.
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