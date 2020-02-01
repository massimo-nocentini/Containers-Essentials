Extension { #name : #BitArray }

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> associations [
	^ (1 to: bits size) collect: [ :i | i -> (bits byteAt: i) ]
]

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> gtInspectorDotsUsingMondrianBuilder: aMondrian [
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray;
		withTextAbove: [ :anAssoc | 
			String
				streamContents: [ :s | 
					s
						nextPutAll: '(16)' subscript;
						nextPutAll: (anAssoc value printStringBase: 16) reversed;
						nextPut: $|;
						nextPutAll: (anAssoc value printStringBase: 10);
						nextPutAll: '(10)' subscript ] ].
	aMondrian
		nodes: self associations
		forEach:
			[ :anAssociation | anAssociation value gtInspectorDotsUsingMondrianBuilder: aMondrian ].
	aMondrian layout grid
		lineItemsCount: 16;
		gapSize: 10
]

{ #category : #'*Collections-Native-BitArray-Visualizations' }
BitArray >> gtInspectorDotsViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Dots';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorDotsUsingMondrianBuilder: b ];
		yourself
]
