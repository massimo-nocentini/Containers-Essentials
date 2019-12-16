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
UnionFind class >> empty [
	^ self basicNew
		parent: Dictionary new;
		rank: Dictionary new;
		initialize;
		useIterativeFind;
		yourself
]

{ #category : #accessing }
UnionFind >> at: x [
	^ findStrategy at: x in: dict
]

{ #category : #accessing }
UnionFind >> insert: x [
	^ dict
		at: x
		ifPresent: [ self error ]
		ifAbsentPut: [ rank at: x put: 0.
			x ]
]

{ #category : #initialization }
UnionFind >> parent: aDict [
	dict := aDict
]

{ #category : #accessing }
UnionFind >> postCopy [
	^ self
		parent: dict copy;
		rank: rank copy;
		yourself
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
UnionFind >> size [
	^ dict size
]

{ #category : #accessing }
UnionFind >> union: x with: y [
	| rx ry |
	rx := dict
		at: x
		ifPresent: [ self at: x ]
		ifAbsent: [ self insert: x ].
	ry := dict
		at: y
		ifPresent: [ self at: y ]
		ifAbsent: [ self insert: y ].
	^ rx = ry
		ifTrue: [ rx ]
		ifFalse: [ | v w |
			v := rank at: rx.
			w := rank at: ry.
			v > w
				ifTrue: [ dict at: ry put: rx ]
				ifFalse: [ v = w
						ifTrue: [ rank at: ry put: w + 1 ].
					dict at: rx put: ry ] ]
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
