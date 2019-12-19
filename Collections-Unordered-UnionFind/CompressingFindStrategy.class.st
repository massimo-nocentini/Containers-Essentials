Class {
	#name : #CompressingFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict select: aPredicate [
	^ self
		at: x
		in: dict
		select: aPredicate
		representativeSoFar: nil
]

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict select: aPredicate representativeSoFar: aRepresentative [
	| w |
	w := dict at: x.
	^ x = w
		ifTrue: [ w -> (aRepresentative ifNil: [ w ]) ]
		ifFalse: [ | anAssoc |
			anAssoc := self
				at: w
				in: dict
				select: aPredicate
				representativeSoFar:
					((aPredicate value: w)
						ifTrue: [ w ]
						ifFalse: [ aRepresentative ]).
			dict at: x put: anAssoc key.
			anAssoc ]
]
