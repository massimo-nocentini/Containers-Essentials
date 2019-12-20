Class {
	#name : #UnionFind,
	#superclass : #Object,
	#instVars : [
		'rank',
		'findStrategy',
		'representativeBlock',
		'parent'
	],
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #operations }
UnionFind class >> empty [
	^ self new
		parent: Dictionary new;
		rank: Dictionary new;
		representativeBlock: [ :each | false ];
		useCompressingFind;
		yourself
]

{ #category : #accessing }
UnionFind >> associations [
	^ parent associations
]

{ #category : #accessing }
UnionFind >> at: x [
	^ findStrategy at: x in: parent select: representativeBlock
]

{ #category : #'as yet unclassified' }
UnionFind >> includesKey: aKey [
	^ parent includesKey: aKey
]

{ #category : #accessing }
UnionFind >> insert: x [
	^ parent
		at: x
		ifPresent: [ self error ]
		ifAbsentPut: [ rank at: x put: 0. x ]
]

{ #category : #accessing }
UnionFind >> keys [
	^ parent keys
]

{ #category : #initialization }
UnionFind >> parent: aDict [
	parent := aDict
]

{ #category : #accessing }
UnionFind >> postCopy [
	^ self
		parent: parent copy;
		rank: rank copy;
		yourself
]

{ #category : #accessing }
UnionFind >> printOn: aStream key: x [
	| r |
	r := rank at: x.
	x printOn: aStream.
	aStream
		nextPutAll:
			(r isInteger
				ifTrue: [ r printSubscriptString ]
				ifFalse: [ r printString ])
]

{ #category : #accessing }
UnionFind >> rank: aDict [
	rank := aDict
]

{ #category : #accessing }
UnionFind >> representativeBlock: aPredicate [
	representativeBlock := aPredicate
]

{ #category : #accessing }
UnionFind >> size [
	^ parent associations
		foldr: [ :each :acc | (each key ~= each value) asBit + acc ]
		init: 0
]

{ #category : #accessing }
UnionFind >> union: x with: y [
	| rx ry |
	"Prepare stuff for x."
	parent at: x ifAbsent: [ self insert: x ].
	rx := (self at: x) key.

	"Prepare stuff for y."
	parent at: y ifAbsent: [ self insert: y ].
	ry := (self at: y) key.

	"Go."
	^ rx = ry
		ifTrue: [ rx ]
		ifFalse: [ | v w |
			v := rank at: rx.
			w := rank at: ry.
			v > w
				ifTrue: [ parent at: ry put: rx ]
				ifFalse: [ v = w
						ifTrue: [ rank at: ry put: w + 1 ].
					parent at: rx put: ry ] ]
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
