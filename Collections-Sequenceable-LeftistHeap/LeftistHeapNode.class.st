Class {
	#name : #LeftistHeapNode,
	#superclass : #LeftistHeap,
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #'as yet unclassified' }
LeftistHeapNode >> insert: aValue left: leftHeap right: rightHeap [
	| v w heap |
	v := leftHeap rank.
	w := rightHeap rank.
	heap := self class new
		value: aValue;
		yourself.
	(self isRank: v lessThan: w)
		ifTrue: [ heap
				rank: v + 1;
				previousLink: rightHeap;
				nextLink: leftHeap ]
		ifFalse: [ heap
				rank: w + 1;
				previousLink: leftHeap;
				nextLink: rightHeap ].
	^ heap
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
				right: (nextLink mergeHeapNode: aNode) ]
		ifFalse: [ self
				insert: w
				left: aNode previousLink
				right: (aNode nextLink mergeHeapNode: self) ]
]

{ #category : #'as yet unclassified' }
LeftistHeapNode >> min [
	^ self value
]

{ #category : #'building - graph' }
LeftistHeapNode >> nodes: aValueLink [
	^ nextLink nodes: (previousLink nodes: self ~~> aValueLink)
]

{ #category : #removing }
LeftistHeapNode >> pop [
	^ previousLink merge: nextLink
]
