Class {
	#name : #UnionFind,
	#superclass : #Object,
	#instVars : [
		'rank',
		'findStrategy',
		'representativeBlock',
		'parent',
		'representative'
	],
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #operations }
UnionFind class >> empty [
	^ self new
		parent: Dictionary new;
		rank: Dictionary new;
		representative: Dictionary new;
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
		representative: representative copy;
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
UnionFind >> representative: aDictionary [
	representative := aDictionary
]

{ #category : #accessing }
UnionFind >> representativeAt: x [
	^ representative at: (self at: x) ifAbsent: [ x ]
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
	^ self union: x with: y consistent: [ :root :reprs | root ]
]

{ #category : #accessing }
UnionFind >> union: x with: y consistent: aBlock [
	| rx ry rxAssoc ryAssoc representatives r root |
	representatives := Set new.

	"Prepare stuff for x."
	parent at: x ifAbsent: [ self insert: x ].
	rxAssoc := self at: x.
	rx := rxAssoc key.

	"Prepare stuff for y."
	parent at: y ifAbsent: [ self insert: y ].
	ryAssoc := self at: y.
	ry := ryAssoc key.

	"Go."
	root := rx = ry
		ifTrue: [ rx ]
		ifFalse: [ | v w |
			v := rank at: rx.
			w := rank at: ry.
			v > w
				ifTrue: [ parent at: ry put: rx ]
				ifFalse: [ v = w
						ifTrue: [ rank at: ry put: w + 1 ].
					parent at: rx put: ry ] ].
	"Collect representatives."
	representatives := Set new
		addAll: rxAssoc value;
		addAll: ryAssoc value;
		yourself.
	r := aBlock cull: root cull: representatives.
	representative at: root put: r.
	^ root
]

{ #category : #accessing }
UnionFind >> useCompressingFind [
	findStrategy := CompressingFindStrategy new
]

{ #category : #accessing }
UnionFind >> useIterativeFind [
	findStrategy := IterativeFindStrategy new
]
