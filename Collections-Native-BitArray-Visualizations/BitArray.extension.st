Extension { #name : #BitArray }

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> gtInspectorDotsUsingMondrianBuilder: aMondrian [
	| nodes lastAssoc |
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray;
		withTextAbove: [ :anAssoc | 
			String
				streamContents: [ :s | 
					| byte |
					byte := anAssoc value key.
					s
						nextPutAll: '(16)' subscript;
						nextPutAll: (byte printStringBase: 16) reversed;
						nextPut: $:;
						nextPutAll: (byte printStringBase: 10);
						nextPutAll: '(10)' subscript ] ].
	bits size
		ifNotZero: [ :size | 
			lastAssoc := (bits byteAt: size)
				->
					(nbits % 8
						ifZero: [ Maybe nothing ]
						ifNotZero: [ :bs | Maybe just: 8 - bs ]).
			nodes := Array
				with: size -> lastAssoc
				withAll:
					((size - 1 to: 1 by: -1)
						collect: [ :i | i -> ((bits byteAt: i) -> Maybe nothing) ]).
			aMondrian
				nodes: nodes reversed
				forEach: [ :anAssociation | 
					| byteMaybeAssociation |
					byteMaybeAssociation := anAssociation value.
					byteMaybeAssociation key
						gtInspectorDotsBlanksMaybe: byteMaybeAssociation value
						usingMondrianBuilder: aMondrian ] ].
	aMondrian layout grid
		lineItemsCount: 16;
		gapSize: 10
]

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> gtInspectorDotsViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Hex Dump (dots repr)';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorDotsUsingMondrianBuilder: b ];
		yourself
]

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> gtInspectorItemInSequenceableCollection: aCollection at: i usingMondrianBuilder: aMondrian [
	self gtInspectorDotsUsingMondrianBuilder: aMondrian
]
