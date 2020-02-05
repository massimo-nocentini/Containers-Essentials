Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-Visualizations' }
ByteArray >> gtInspectorBitsUsingMondrianBuilder: aMondrian [
	aMondrian shape circle
		fillColor: [ :bit | 
			bit
				ifTrue: [ Color black ]
				ifFalse: [ Color white ] ];
		borderColor: [ Color black ].
	aMondrian nodes: (self asOrderedCollection flatCollect: #eightBits).
	aMondrian layout grid lineItemsCount: 16 * 8
]

{ #category : #'*Collections-Native-Visualizations' }
ByteArray >> gtInspectorBitsViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Bit Dump';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorBitsUsingMondrianBuilder: b ];
		yourself
]
