"
I am a relation between two objects, `left` and `right`. `is:greaterThan:` makes a `CTRelationGreaterThan` if the first object is greater than the second, and one of me otherwise, so that the dispatch on my class takes the place of `ifTrue:ifFalse:`.

`Integer>>#slowExplicitFibonacci:tail:` works so: it sends me `slowExplicitFibonacci:tail:greaterThanZero:`, and I send the integer `slowExplicitFibonacci:tail:greaterThanZeroIsFalse:` back, while a `CTRelationGreaterThan` sends `slowExplicitFibonacci:tail:greaterThanZeroIsTrue:`.

```smalltalk
10 slowExplicitFibonacci: 1 tail: 0 ""55""
```
"
Class {
	#name : 'CTRelation',
	#superclass : 'Object',
	#instVars : [
		'left',
		'right'
	],
	#category : 'Containers-Essentials-Messaging',
	#package : 'Containers-Essentials',
	#tag : 'Messaging'
}

{ #category : 'testing' }
CTRelation class >> is: a greaterThan: b [

	^ (a > b
		   ifTrue: [ CTRelationGreaterThan ]
		   ifFalse: [ self ]) new
		  left: a;
		  right: b;
		  yourself
]

{ #category : 'accessing' }
CTRelation >> left [

	^ left
]

{ #category : 'accessing' }
CTRelation >> left: anObject [

	left := anObject
]

{ #category : 'accessing' }
CTRelation >> right [

	^ right
]

{ #category : 'accessing' }
CTRelation >> right: anObject [

	right := anObject
]

{ #category : 'as yet unclassified' }
CTRelation >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	^ aReceiver
		  slowExplicitFibonacci: anInteger
		  tail: anotherInteger
		  greaterThanZeroIsFalse: self
]
