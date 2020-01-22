Class {
	#name : #LeftistHeapNode,
	#superclass : #LeftistHeap,
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #'as yet unclassified' }
LeftistHeapNode >> insert: aValue left: leftHeap right: rightHeap rankComparer: aBlock [
	| v w |
	v := leftHeap rank.
	w := rightHeap rank.
	^ (self isRank: v lessThan: w)
		ifTrue: [ self class new
				rank: v + 1;
				value: aValue;
				previousLink: rightHeap;
				nextLink: leftHeap;
				yourself ]
		ifFalse: [ self class new
				rank: w + 1;
				value: aValue;
				previousLink: leftHeap;
				nextLink: rightHeap;
				yourself ]
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> isEmpty [
	^ false
]

{ #category : #comparing }
LeftistHeapNode >> isRank: i lessThan: j [
	^ i < j
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> merge: aLeftistHeap [
	^ aLeftistHeap mergeHeapNode: self
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> mergeHeapNode: aNode [
	| w |
	w := aNode value.
	^ value <= w
		ifTrue: [ self
				insert: value
				left: previousLink
				right: (nextLink mergeHeapNode: aNode)
				rankComparer: #< ]
		ifFalse: [ self
				insert: w
				left: aNode previousLink
				right: (aNode nextLink mergeHeapNode: self)
				rankComparer: #< ]
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> min [
	^ self value
]

{ #category : #removing }
LeftistHeapNode >> pop [
	^ previousLink merge: nextLink
]
