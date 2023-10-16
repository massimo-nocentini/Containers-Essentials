Extension { #name : 'BlockClosure' }

{ #category : '*Containers-Essentials' }
BlockClosure >> ! anArgument [

	^ self value: anArgument
]

{ #category : '*Containers-Essentials' }
BlockClosure >> !! args [

	^ self valueWithArguments: args
]

{ #category : '*Containers-Essentials' }
BlockClosure >> , anObject [

	^ anObject prependBlock: self
]

{ #category : '*Containers-Essentials' }
BlockClosure >> ? anArgument [

	^ self cull: anArgument
]

{ #category : '*Containers-Essentials' }
BlockClosure >> ?? args [

	^ self valueWithEnoughArguments: args
]

{ #category : '*Containers-Essentials' }
BlockClosure >> for: guardBlock collect: collectBlock do: doBlock then: updateBlock [

	^ self
		  for: guardBlock
		  collect: collectBlock
		  do: doBlock
		  then: updateBlock
		  ifBroken: [ :arg | arg ]
]

{ #category : '*Containers-Essentials' }
BlockClosure >> for: guardBlock collect: collectBlock do: doBlock then: updateBlock ifBroken: breakBlock [

	"General iterator message."

	| value i |
	"Init"
	value := self value.

	"Iterations."
	i := 1.
	[ guardBlock cull: value cull: i ] whileTrue: [ 
		| each |
		each := collectBlock cull: value cull: i.

		value := doBlock
			         cull: [ ^ breakBlock cull: each cull: value cull: i ]
			         cull: each
			         cull: value
			         cull: i.

		updateBlock cull: each cull: value cull: i.

		i := i + 1 ].

	^ value
]

{ #category : '*Containers-Essentials' }
BlockClosure >> for: guardBlock do: doBlock then: updateBlock [

	^ self
		  for: guardBlock
		  do: doBlock
		  then: updateBlock
		  ifBroken: [ :arg | arg ]
]

{ #category : '*Containers-Essentials' }
BlockClosure >> for: guardBlock do: doBlock then: updateBlock ifBroken: breakBlock [

	^ self
		  for: guardBlock
		  collect: [ :arg | arg ]
		  do: doBlock
		  then: updateBlock
		  ifBroken: breakBlock
]

{ #category : '*Containers-Essentials' }
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

{ #category : '*Containers-Essentials' }
BlockClosure >> prependBlock: aFullBlockClosure [

	^ [ :v | self value: (aFullBlockClosure value: v) ]
]

{ #category : '*Containers-Essentials' }
BlockClosure >> valueWithArgumentedExit [

	^ self value: [ :anObject | ^ anObject ]
]
