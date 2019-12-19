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
	^ parent
		at: aKey
		ifPresent: [ :aValue | aKey ~= aValue ]
		ifAbsent: [ false ]
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
	| rx ry rxkey rykey |
	"Prepare stuff for x."
	parent at: x ifAbsent: [ self insert: x ].
	rx := self at: x.
	rxkey := rx key.

	"Prepare stuff for y."
	parent at: y ifAbsent: [ self insert: y ].
	ry := self at: y.
	rykey := ry key.

	"Go."
	^ rxkey = rykey
		ifTrue: [ rx value ]
		ifFalse: [ | v w |
			v := rank at: rxkey.
			w := rank at: rykey.
			v > w
				ifTrue: [ parent at: rykey put: rxkey.
					rx value ]
				ifFalse: [ v = w
						ifTrue: [ rank at: rykey put: w + 1 ].
					parent at: rxkey put: rykey.
					ry value ] ]
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
