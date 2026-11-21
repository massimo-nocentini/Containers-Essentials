Extension { #name : 'CTArray2D' }

{ #category : '*Containers-Essentials-Visualizations' }
CTArray2D >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitArray2D: self
]

{ #category : '*Containers-Essentials-Visualizations' }
CTArray2D >> asArrayOfLinks [
	"One link for each of my rows, from the top one, with the values of the row from left to right"

	^ (1 to: self height) collect: [ :row |
		  | link |
		  link := nil.
		  1 to: self width do: [ :column |
			  link := (self atColumn: column atRow: row) ~~> link ].
		  link reversed ]
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
