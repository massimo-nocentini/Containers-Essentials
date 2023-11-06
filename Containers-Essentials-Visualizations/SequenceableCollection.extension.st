Extension { #name : 'SequenceableCollection' }

{ #category : '*Containers-Essentials-Visualizations' }
SequenceableCollection >> asShapeFordCircles [

	| r c ratio |
	c := Float goldenRatio double.
	r := (self detectMin: [ :each | each fordRadius ]) fordRadius.
	ratio := c / r.

	^ RSComposite new
		  model: self;
		  shapes: (self collect: [ :each | 
					   | radius |
					   radius := each fordRadius * ratio.
					   RSCircle new
						   model: each;
						   withBorder;
						   color: Color white;
						   position: each * ratio @ radius negated;
						   radius: radius;
						   yourself ]);
		  yourself
]
