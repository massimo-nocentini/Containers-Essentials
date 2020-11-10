Class {
	#name : #LeftistHeap,
	#superclass : #CTBinaryTreeAbstract,
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
