Extension { #name : 'SortedCollection' }

{ #category : '*Containers-Essentials' }
SortedCollection class >> array: anArray sortUsing: aBlockOrSortFunction [

	^ (self sortUsing: aBlockOrSortFunction)
		  instVarNamed: #array put: anArray;
		  instVarNamed: #firstIndex put: 1;
		  instVarNamed: #lastIndex put: anArray size;
		  yourself
]

{ #category : '*Containers-Essentials' }
SortedCollection >> indexOf: anElement startingAt: useless ifAbsent1: aBlock [

	^ self
		  indexOf: anElement
		  startingAt: useless
		  ifAbsent: aBlock
		  using1: (sortBlock ifNil: [ [ :a :b | a <= b ] ])
]

{ #category : '*Containers-Essentials' }
SortedCollection >> indexOf: anElement startingAt: _ ifAbsent: aBlock using1: sorting [

	array ifNotNil: [
		| i j |
		i := firstIndex.
		j := lastIndex.

		i isInteger & j isInteger & (i > 0) & (j <= array size) ifFalse: [
			^ aBlock value ].

		[ i <= j ] whileTrue: [
			| obj m |
			m := i + j >> 1.
			obj := array at: m.
			anElement = obj
				ifTrue: [ ^ m - firstIndex + 1 ]
				ifFalse: [
					(sorting value: anElement value: obj)
						ifTrue: [ j := m - 1 ]
						ifFalse: [ i := m + 1 ] ] ] ].

	^ aBlock value
]
