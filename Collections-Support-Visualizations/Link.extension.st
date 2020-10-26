Extension { #name : #Link }

{ #category : #'*Collections-Support-Visualizations' }
Link >> asSlotsGroupKnownReferences: aSet recursiveReferences: refs [
	^ self
		  asSlotsGroupKnownReferences: aSet
		  recursiveReferences: refs
		  layoutBlock: [ :shapes | RSVerticalLineLayout on: shapes ]
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> asSlotsGroupKnownReferences: aSet recursiveReferences: links layoutBlock: lBlock [
	| shapes edges aNewSet |
	aNewSet := aSet | links.
	shapes := links collect: [ :aValueLink | 
		          | g |
		          g := aValueLink asSlotsGroupKnownReferences: aNewSet.
		          (g asShapeFor: aValueLink) @ RSDraggable ].
	edges := (RSEdgeBuilder new: (RSPolyline new
				           border: (RSBorder new width: 1);
				           cornerRadii: 5;
				           markerEnd: RSArrowedLine new defaultHead asMarker;
				           controlPointsController: (RSBlockCPController new
						            block: [ :edge | 
							            | f t ap |
							            ap := edge attachPoint.
							            f := ap startingPointOf: edge.
							            t := ap endingPointOf: edge.
							            edge to model == shapes first model
								            ifTrue: [ 
									            | bottom left rect |
									            rect := shapes last encompassingRectangle.
									            bottom := rect bottom + 5.
									            left := rect left - 5.
									            Array
										            with: f
										            with: f x @ bottom
										            with: left @ bottom
										            with: left @ t y
										            with: t ]
								            ifFalse: [ Array with: f with: t ] ];
						            yourself);
				           yourself))
		         color: Color gray;
		         toShapes: shapes;
		         fromShapes: (links
				          with: shapes
				          collect: [ :link :shape | 
				          shape shapeFromModel: link nextLink ]);
		         useAssociations:
		         (links collect: [ :r | r asReflexiveAssociation ]).
	lBlock value: shapes.
	^ RSGroup new
		  addAll: shapes;
		  addAll: edges;
		  yourself
]
