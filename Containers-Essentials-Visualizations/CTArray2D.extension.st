Extension { #name : 'CTArray2D' }

{ #category : '*Containers-Essentials-Visualizations' }
CTArray2D >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitArray2D: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CTArray2D >> asArrayOfLinks [

	^ Array streamContents: [ :aStream | 
		  | link r |
		  r := 1.
		  link := nil.
		  self withIndicesDo: [ :each :row :column | 
			  r < row ifTrue: [ 
				  aStream nextPut: link reversed.
				  link := nil.
				  r := row ].
			  link := each ~~> link ].
		  aStream nextPut: link reversed ]
]

{ #category : '*Containers-Essentials-Visualizations' }
CTArray2D >> asShapeMod2 [

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
		lineItemsCount: self numberOfColumns;
		applyOn: shapes.

	^ RSComposite new
		  model: self;
		  shapes: shapes;
		  yourself
]
