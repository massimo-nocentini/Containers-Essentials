Extension { #name : #Array2D }

{ #category : #'*Containers-Essentials-Visualizations' }
Array2D >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitArray2D: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Array2D >> asShapeMod2 [

	| shapes |
	shapes := contents collect: [ :each | 
		          RSCircle new
			          radius: Float goldenRatio double double;
			          withBorder;
			          color: Color white;
			          yourself: [ :c | "radius: (each / Float π) sqrt * Float goldenRatio;" 
				          each % 2 = 1 ifTrue: [ c sameColorAsBorderColor ] ] ].

	RSGridLayout new
		gapSize: Float goldenRatio double;
		lineItemsCount: numberOfColumns;
		applyOn: shapes.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]
