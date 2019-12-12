Class {
	#name : #UnionFind,
	#superclass : #Object,
	#instVars : [
		'dict',
		'rank'
	],
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
UnionFind >> at: x [
	| item next |
	item := x.
	[ (next := dict at: item) = item ] whileFalse: [ item := next ].
	^ item
]

{ #category : #initialization }
UnionFind >> initialize [
	super initialize.
	dict := Dictionary new.
	rank := Dictionary new
]

{ #category : #accessing }
UnionFind >> printOn: aStream key: x [
	x printOn: aStream.
	aStream nextPutAll: (rank at: x) printSubscriptString
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
		ifFalse: [ (rank at: rx) > (rank at: ry)
				ifTrue: [ dict at: ry put: rx ]
				ifFalse: [ | r |
					r := rank at: ry.
					dict at: rx put: ry.
					(rank at: rx) = r
						ifTrue: [ rank at: ry put: r + 1 ] ] ]
]
