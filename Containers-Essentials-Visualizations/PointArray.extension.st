Extension { #name : #PointArray }

{ #category : #'*Containers-Essentials-Visualizations' }
PointArray >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPointArray: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
PointArray >> asShapeDots [

	| twoGR |
	twoGR := Float goldenRatio * 2.

	^ RSComposite new
		  shapes: (self asArray collect: [ :each | 
					   RSCircle new
						   model: self;
						   radius: twoGR;
						   withBorder;
						   position: each * twoGR;
						   yourself: [ :c | 
							   each isZero
								   ifTrue: [ c sameColorAsBorderColor ]
								   ifFalse: [ c color: Color white translucent ] ] ]);
		  yourself
]
