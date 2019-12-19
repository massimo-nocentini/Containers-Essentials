Class {
	#name : #UnionFind,
	#superclass : #Object,
	#instVars : [
		'dict',
		'rank',
		'findStrategy',
		'representativeBlock'
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
	^ dict associations
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
		ifAbsentPut: [ | r |
			r := (representativeBlock value: x)
				ifTrue: [ Float infinity ]
				ifFalse: [ 0 ].
			rank at: x put: r.
			x ]
]

{ #category : #accessing }
UnionFind >> keys [
	^ dict keys
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
	^ dict associations
		foldr: [ :each :acc | (each key == each value) not asBit + acc ]
		init: 0
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
