Extension { #name : #ByteArray }

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitByteArray: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> asShapeBitsDump [

	| shapes dGR |
	dGR := Float goldenRatio double.

	shapes := self asArray collect: [ :byte | 
		          | bits composite box |
		          bits := byte eightBits reversed collect: [ :bit | 
			                  RSCircle new
				                  model: bit;
				                  radius: dGR double;
				                  withBorder;
				                  yourself: [ :circle | 
					                  circle color: (bit
								                   ifTrue: [ circle border color ]
								                   ifFalse: [ Color white ]) ] ].

		          RSHorizontalLineLayout new
			          gapSize: Float goldenRatio;
			          on: bits.

		          composite := RSComposite new
			                       shapes: bits;
			                       "
			                       padding: dGR;"
				                       yourself.

		          box := RSBox new
			                 extent: composite extent;
			                 withBorder;
			                 color: Color white;
			                 cornerRadius: dGR;
			                 yourself.

		          RSLocation new center stick: composite on: box.

		          RSComposite new
			          model: byte;
			          shapes: { 
					          box.
					          composite };
			          yourself.

		          composite ].

	RSVerticalLineLayout new
		gapSize: dGR half;
		on: shapes.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> inspectorCanvasBitsDumpBigEndian [

	<inspectorPresentationOrder: 20 title: 'Bits dump (big-endian)'>
	^ RSCanvas new
		  add: self asShapeBitsDump;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> inspectorCanvasBitsDumpBigEndianContext: aContext [

	aContext withoutEvaluator
]
