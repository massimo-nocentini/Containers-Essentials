Class {
	#name : #IterativeFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
IterativeFindStrategy >> at: x in: dict [
	| item next |
	item := x.
	[ (next := dict at: item) = item ] whileFalse: [ item := next ].
	^ item
]
