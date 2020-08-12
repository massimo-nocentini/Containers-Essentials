Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-Visualizations' }
ByteArray >> gtInspectorBitsDumpBigEndianViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Bits dump (big-endian)';
		  initializeCanvas: [ 
			  | aCanvas bits shapes |
			  aCanvas := RSCanvas new.
			  bits := self asOrderedCollection flatCollect: #eightBits.
			  shapes := bits collect: [ :bit | 
					            RSEllipse new
						            radius: 5;
						            color: (bit
								             ifTrue: [ Color black ]
								             ifFalse: [ Color white ]);
						            withBorder;
						            borderColor: Color black;
						            yourself ].
			  RSGridLayout on: shapes withLineItemsCount: 16 * 8.
			  aCanvas addAll: shapes.
			  aCanvas @ RSCanvasController ];
		  yourself
]
