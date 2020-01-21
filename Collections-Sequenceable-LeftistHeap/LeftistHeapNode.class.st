Class {
	#name : #LeftistHeapNode,
	#superclass : #LeftistHeap,
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #'as yet unclassified' }
LeftistHeapNode >> merge: aLeftistHeap [
	^ aLeftistHeap mergeHeapNode: self
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> mergeHeapNode: aNode [
	| w |
	w := aNode value.
	^ value < w
		ifTrue: [ LeftistHeap
				key: #<
				value: value
				left: previousLink
				right: (nextLink mergeHeapNode: aNode) ]
		ifFalse: [ LeftistHeap
				key: #<
				value: w
				left: aNode previousLink
				right: (aNode nextLink mergeHeapNode: self) ]
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> min [
	^ self value
]

{ #category : #removing }
LeftistHeapNode >> pop [
	^ previousLink merge: nextLink
]

{ #category : #printing }
LeftistHeapNode >> printStringWithSubscriptRank [
	^ String
		streamContents: [ :s | 
			value printOn: s.
			s"
				nextPut: Character space;"
				nextPut: $₍;
				nextPutAll: rank printSubscriptString;
				nextPut: $₎ ]
]
