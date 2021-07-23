Extension { #name : #BlockClosure }

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
