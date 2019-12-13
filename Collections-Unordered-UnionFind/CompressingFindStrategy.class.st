Class {
	#name : #CompressingFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict [
	| w |
	w := dict at: x.
	^ x = w
		ifTrue: [ w ]
		ifFalse: [ dict at: x put: (self at: w in: dict) ]
]
