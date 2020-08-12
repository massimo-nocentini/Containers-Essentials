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

{ #category : #'instance creation' }
LeftistHeap class >> forArrayedCollection: aCollection [
	^ aCollection bisect: #merge: baseBlock: [ :each | self leaf: each ]
]

{ #category : #'instance creation' }
LeftistHeap class >> forSequenceableCollection: aCollection [
	^ aCollection inject: self empty into: #add:
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
	^ self mergeHeapNode: (self class leaf: anObject)
]

{ #category : #'as yet unclassified' }
LeftistHeap >> isEmpty [
	self subclassResponsibility
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

{ #category : #'building - graph' }
LeftistHeap >> nodes: aValueLink [
	self subclassResponsibility
]

{ #category : #removing }
LeftistHeap >> pop [
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
