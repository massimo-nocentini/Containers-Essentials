Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-Visualizations' }
ByteArray >> gtInspectorBitsUsingMondrianBuilder: aMondrian [
	aMondrian shape box
		fillColor: [ :bit | 
			bit = 1
				ifTrue: [ Color black ]
				ifFalse: [ Color white ] ];
		borderColor: [ Color black ].
	aMondrian nodes: (self flatCollect: #eightBits).
	aMondrian layout grid lineItemsCount: 16 * 8
]

{ #category : #'*Collections-Native-Visualizations' }
ByteArray >> gtInspectorBitsViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Hex Dump (bits repr)';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorBitsUsingMondrianBuilder: b ];
		yourself
]
