Class {
	#name : #LeftistHeap,
	#superclass : #DoubleLink,
	#instVars : [
		'rank'
	],
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #requirements }
LeftistHeap class >> empty [
	^ LeftistHeapEmpty new
		rank: 0;
		yourself
]

{ #category : #'as yet unclassified' }
LeftistHeap class >> key: aSelector value: aValue left: leftHeap right: rightHeap [
	| v w |
	v := leftHeap rank.
	w := rightHeap rank.
	^ (v perform: aSelector with: w)
		ifTrue: [ LeftistHeapNode new
				rank: v + 1;
				value: aValue;
				previousLink: rightHeap;
				nextLink: leftHeap;
				yourself ]
		ifFalse: [ LeftistHeapNode new
				rank: w + 1;
				value: aValue;
				previousLink: leftHeap;
				nextLink: rightHeap;
				yourself ]
]

{ #category : #'as yet unclassified' }
LeftistHeap class >> leaf: anObject [
	^ LeftistHeapNode new
		rank: 1;
		value: anObject;
		previousLink: self empty;
		nextLink: self empty;
		yourself
]

{ #category : #'as yet unclassified' }
LeftistHeap >> add: anObject [
	^ self mergeHeapNode: (LeftistHeap leaf: anObject)
]

{ #category : #'as yet unclassified' }
LeftistHeap >> merge: aLeftistHeap [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
LeftistHeap >> mergeHeapNode: aNode [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
LeftistHeap >> min [
	self subclassResponsibility
]

{ #category : #removing }
LeftistHeap >> pop [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
LeftistHeap >> printStringWithSubscriptRank [
	self subclassResponsibility
]

{ #category : #accessing }
LeftistHeap >> rank [
	^ rank
]

{ #category : #accessing }
LeftistHeap >> rank: anObject [
	rank := anObject
]
