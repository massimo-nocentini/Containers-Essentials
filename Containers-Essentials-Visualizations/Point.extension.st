Extension { #name : 'Point' }

{ #category : '*Containers-Essentials-Visualizations' }
Point >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPoint: self
]

{ #category : '*Containers-Essentials-Visualizations' }
Point >> asShapeWrtOrigin [

	| origin zero |
	zero := 0 @ 0.
	origin := RSCircle new
		          model: zero;
		          position: zero;
		          color: Color white;
		          withBorder;
		          yourself: [ :o | 
			          o radius: Float goldenRatio - 1 / 2 * o radius ].
	^ RSComposite new
		  model: self;
		  shapes: { 
				  origin.
				  (RSCircle new
					   model: self;
					   position: self;
					   yourself: [ :o | o radius: Float goldenRatio - 1 * o radius ]) };
		  yourself
]
