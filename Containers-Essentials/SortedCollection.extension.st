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

	array ifNotNil: [
		| i j sorting |
		i := firstIndex.
		j := lastIndex.

		(i > 0 and: [ j <= array size ]) ifFalse: [ ^ aBlock value ].

		sorting := sortBlock ifNil: [ [ :a :b | a <= b ] ].

		[ i <= j ] whileTrue: [
			| obj m |
			m := i + j >> 1.
			obj := array at: m.
			anElement = obj
				ifTrue: [ ^ m ]
				ifFalse: [
					(sorting value: anElement value: obj)
						ifTrue: [ j := m - 1 ]
						ifFalse: [ i := m + 1 ] ] ] ].

	^ aBlock value
]
