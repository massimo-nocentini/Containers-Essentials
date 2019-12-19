Class {
	#name : #CompressingFindStrategy,
	#superclass : #FindStrategy,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
CompressingFindStrategy >> at: x in: dict select: aBlock [
	^ (aBlock value: x)
		ifTrue: [ x ]
		ifFalse: [ | w |
			w := dict at: x.
			x = w
				ifTrue: [ w ]
				ifFalse: [ | root |
					root := self at: w in: dict select: aBlock.
					dict at: x put: root ] ]
]
