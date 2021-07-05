Extension { #name : #Point }

{ #category : #'*Containers-Essentials-Visualizations' }
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
		  shapes: { 
				  origin.
				  (RSCircle new
					   model: self;
					   position: self;
					   yourself) };
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Point >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  #distanceToOrigin asSlotDescriptor.
		  (#asShapeWrtOrigin asSlotDescriptor
			   inline: false;
			   quote) }
]
