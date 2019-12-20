Class {
	#name : #CompressingFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict do: aBlock [
	| w |
	aBlock value: x.
	w := dict at: x.
	^ x = w
		ifTrue: [ w ]
		ifFalse: [ | root |
			root := self at: w in: dict do: aBlock.
			dict at: x put: root ]
]

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict select: aPredicate [
	| aBlock representatives root |
	representatives := OrderedCollection new.
	aBlock := [ :each | 
	(aPredicate value: each)
		ifTrue: [ representatives add: each ] ].
	root := self at: x in: dict do: aBlock.
	^ root -> (representatives ifEmpty: [ root ] ifNotEmpty: #first)
]
