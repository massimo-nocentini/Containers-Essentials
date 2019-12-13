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

{ #category : #'instance creation' }
UnionFind class >> withAll: aCollection [
	| unionFind |
	unionFind := self new.
	aCollection do: [ :each | unionFind insert: each ].
	^ unionFind
]

{ #category : #accessing }
UnionFind >> at: x [
	^ findStrategy at: x in: dict
]

{ #category : #initialization }
UnionFind >> initialize [
	super initialize.
	dict := Dictionary new.
	rank := Dictionary new.
	findStrategy := IterativeFindStrategy new
]

{ #category : #accessing }
UnionFind >> insert: x [
	dict
		at: x
		ifPresent: [ self error ]
		ifAbsentPut: [ rank at: x put: 0.
			x ]
]

{ #category : #accessing }
UnionFind >> printOn: aStream key: x [
	x printOn: aStream.
	aStream nextPutAll: (rank at: x) printSubscriptString
]

{ #category : #accessing }
UnionFind >> union: x with: y [
	| rx ry |
	rx := self at: x.
	ry := self at: y.
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
