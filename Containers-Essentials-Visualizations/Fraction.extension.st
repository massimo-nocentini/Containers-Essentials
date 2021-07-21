Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> asShapeOnUnitCircle [

	| circle point puc scale origin |
	puc := self asPointOnUnitCircle.

	scale := NSScale linear
		         domain: { 0. 1 };
		         range: { 
				         0.
				         (20 * Float goldenRatio) } yourself.

	origin := RSCircle new
		          radius: Float goldenRatio / 2;
		          withBorder;
		          color: Color white;
		          position: 0 asPoint;
		          yourself.

	circle := RSCircle new
		          radius: (scale scale: 1);
		          withBorder;
		          color: Color white;
		          position: 0 asPoint;
		          yourself.

	point := RSCircle new
		         model: puc;
		         radius: Float goldenRatio;
		         withBorder;
		         sameColorAsBorderColor;
		         position: (scale scale: puc);
		         yourself.

	^ RSComposite new
		  model: puc;
		  shapes: (Array with: circle with: origin with: point);
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  (#asPythagoreanTriple asSlotDescriptor
			   noHeader;
			   inline: true;
			   quote: [ :anArray :aDescriptor | 
				   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ]).
		  (#asShapeOnUnitCircle asSlotDescriptor
			   inline: true;
			   quote) }
]
