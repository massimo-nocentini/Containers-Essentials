Extension { #name : #ByteArray }

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> inspectorCanvasBitsDumpBigEndian [

	<inspectorPresentationOrder: 20 title: 'Bits dump (big-endian)'>
	| bits shapes |
	bits := Array streamContents: [ :aStream | 
		        self do: [ :each | aStream nextPutAll: each eightBits ] ].
	shapes := bits collect: [ :bit | 
		          RSEllipse new
			          model: bit;
			          radius: 5;
			          color: (bit
					           ifTrue: [ Color gray ]
					           ifFalse: [ Color white ]);
			          withBorder;
			          yourself ].
	RSGridLayout on: shapes withLineItemsCount: 16 * 8.
	^ RSCanvas new
		  addAll: shapes;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> inspectorCanvasBitsDumpBigEndianContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> instVarsNamesOrderedCollection [

	^ #( hex asArray )
]
