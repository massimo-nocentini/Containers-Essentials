Class {
	#name : #UnionFind,
	#superclass : #Object,
	#instVars : [
		'dict',
		'rank',
		'findStrategy'
	],
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #operations }
UnionFind class >> create [
	^ self basicNew
		parent: Dictionary new;
		rank: Dictionary new;
		initialize;
		yourself
]

{ #category : #accessing }
UnionFind >> at: x [
	^ findStrategy at: x in: dict
]

{ #category : #initialization }
UnionFind >> parent: aDict [
	dict := aDict
]

{ #category : #accessing }
UnionFind >> printOn: aStream key: x [
	x printOn: aStream.
	aStream nextPutAll: (rank at: x) printSubscriptString
]

{ #category : #accessing }
UnionFind >> rank: aDict [
	rank := aDict
]

{ #category : #accessing }
UnionFind >> union: x with: y [
	| rx ry |
	rx := dict
		at: x
		ifPresent: [ self at: x ]
		ifAbsentPut: [ rank at: x put: 0.
			x ].
	ry := dict
		at: y
		ifPresent: [ self at: y ]
		ifAbsentPut: [ rank at: y put: 0.
			y ].
	rx = ry
		ifFalse: [ | v w |
			v := rank at: rx.
			w := rank at: ry.
			v > w
				ifTrue: [ dict at: ry put: rx ]
				ifFalse: [ dict at: rx put: ry.
					v = w
						ifTrue: [ rank at: ry put: w + 1 ] ] ]
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
