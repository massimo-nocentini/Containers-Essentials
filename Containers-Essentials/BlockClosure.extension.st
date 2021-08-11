Extension { #name : #BlockClosure }

{ #category : #'*Containers-Essentials' }
BlockClosure >> !! args [
	^ self valueWithArguments: args
]

{ #category : #'*Containers-Essentials' }
BlockClosure >> , aBlock [
	aBlock numArgs = 1
		ifTrue: [ ^ [ :a | self valueWithArguments: (aBlock value: a) ] ].
	aBlock numArgs = 2
		ifTrue: [ ^ [ :a :b | self valueWithArguments: (aBlock value: a value: b) ] ].
	aBlock numArgs = 3
		ifTrue: [ ^ [ :a :b :c | self valueWithArguments: (aBlock value: a value: b value: c) ] ].
	aBlock numArgs = 4
		ifTrue: [ ^ [ :a :b :c :d | 
			self
				valueWithArguments:
					(aBlock
						value: a
						value: b
						value: c
						value: d) ] ]
]

{ #category : #'*Containers-Essentials' }
BlockClosure >> kissingFractions [

	| fractions news level |
	level := 1.
	fractions := SortedCollection with: 0 with: 1.

	[ 
	news := OrderedCollection new.
	fractions overlappingPairsDo: [ :a :b | 
		| f |
		f := a \/ b.
		(self
			 cull: f
			 cull: fractions
			 cull: news
			 cull: level) ifTrue: [ news add: f ] ].
	news isEmpty ] whileFalse: [ 
		fractions addAll: news.
		level := level + 1 ].

	^ fractions
		  removeFirst;
		  removeLast;
		  asArray
]
