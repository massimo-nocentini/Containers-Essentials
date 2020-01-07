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
		ifAbsentPut: [ 
			
			"First set the rank of a newly created node."
			rank at: x put: 0.

			"Finally return the inserted object."
			x ]
]

{ #category : #accessing }
UnionFind >> keys [
	^ parent keys
]

{ #category : #accessing }
UnionFind >> link: rx with: ry [
	^ rx = ry
		ifTrue: [ rx ]
		ifFalse: [ | v w |
			v := rank at: rx.
			w := rank at: ry.
			v > w
				ifTrue: [ parent at: ry put: rx ]
				ifFalse: [ | x y |
					x := rx.
					y := ry.
					v = w
						ifTrue: [ (representativeBlock value: x)
								ifTrue: [ | z |
									z := y.
									y := x.
									x := z ].
							rank at: y put: w + 1 ].
					parent at: x put: y ] ]
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
	"First ensure that objects will be inserted as objects."

	parent
		at: x ifAbsent: [ self insert: x ];
		at: y ifAbsent: [ self insert: y ].

	"Then link them together."
	^ self link: (self at: x) key with: (self at: y) key
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
