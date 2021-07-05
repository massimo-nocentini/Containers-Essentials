Extension { #name : #Color }

{ #category : #'*Containers-Essentials-Visualizations' }
Color >> asShapeColoredBox [

	^ RSBox new
		  color: self;
		  model: self;
		  size: Float goldenRatio * 15;
		  cornerRadius: Float goldenRatio double;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Color >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { (#asShapeColoredBox asSlotDescriptor
			   inline: true;
			   quote) }
]
