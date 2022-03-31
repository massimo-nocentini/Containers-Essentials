Extension { #name : #ByteArray }

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitByteArray: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
ByteArray >> asShapeBitsDump: aWalker [

	| shapes dGR gapSize |
	dGR := aWalker shapeBuilder radiusOrPadding.
	gapSize := dGR halved.

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
			          gapSize: gapSize;
			          on: bits.

		          composite := RSComposite new
			                       shapes: bits;
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
		gapSize: gapSize;
		on: shapes.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]
