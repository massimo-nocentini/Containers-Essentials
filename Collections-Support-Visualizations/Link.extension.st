Extension { #name : #Link }

{ #category : #'*Collections-Support-Visualizations' }
Link >> asSlotsShapeKnownReferences: aSet recursiveReferences: links [
	| shapes edges eb |
	shapes := links collect: [ :aValueLink | 
		          | g |
		          g := aValueLink asSlotsShapeKnownReferences: aSet | links.
		          (g asShapeFor: aValueLink) @ RSDraggable ].
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: shapes;
		      yourself.
	edges := eb
		         fromShapes: (links
				          with: shapes
				          collect: [ :link :shape | 
					          shape shapeFromModel: link nextLink ]);
		         useAssociations:
			         (links collect: [ :r | r asReflexiveAssociation ]).
	RSVerticalLineLayout on: shapes.
	^ RSGroup new
		  addAll: shapes;
		  addAll: edges;
		  yourself
]
