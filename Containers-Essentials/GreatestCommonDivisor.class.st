Class {
	#name : #GreatestCommonDivisor,
	#superclass : #QuoRemComplementary,
	#instVars : [
		'equations'
	],
	#category : #'Containers-Essentials'
}

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

{ #category : #accessing }
GreatestCommonDivisor >> instVarsNamesOrderedCollection [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  #equations asSlotDescriptor instVarNameHasBeenGiven.
		  ('a/gcd' asSlotDescriptor
			   blockClosure: [ (QuoRemStandard a: a b: self value) asShapeDots ];
			   inline: true;
			   quote).
		  ('b/gcd' asSlotDescriptor
			   blockClosure: [ (QuoRemStandard a: b b: self value) asShapeDots ];
			   inline: true;
			   quote) }
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
