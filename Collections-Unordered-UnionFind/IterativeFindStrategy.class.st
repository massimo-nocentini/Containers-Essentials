Class {
	#name : #IterativeFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
IterativeFindStrategy >> at: x in: dict select: aBlock [
	| item next |
	item := x.
	[ (aBlock value: item)
		ifTrue: [ ^ item ].
	(next := dict at: item) = item ] whileFalse: [ item := next ].
	^ item
]
