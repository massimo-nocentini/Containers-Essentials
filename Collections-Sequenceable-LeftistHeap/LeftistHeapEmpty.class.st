Class {
	#name : #LeftistHeapEmpty,
	#superclass : #LeftistHeap,
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #'as yet unclassified' }
LeftistHeapEmpty >> isEmpty [
	^ true
]

{ #category : #'as yet unclassified' }
LeftistHeapEmpty >> merge: aLeftistHeap [
	^ aLeftistHeap
]

{ #category : #'as yet unclassified' }
LeftistHeapEmpty >> mergeHeapNode: aNode [
	^ aNode
]

{ #category : #'as yet unclassified' }
LeftistHeapEmpty >> min [
	CollectionIsEmpty signal
]

{ #category : #'as yet unclassified' }
LeftistHeapEmpty >> pop [
	CollectionIsEmpty signal
]
