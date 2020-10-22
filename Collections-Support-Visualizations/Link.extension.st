Extension { #name : #Link }

{ #category : #'*Collections-Support-Visualizations' }
Link >> asValueLinksGroupKnownReferences: aSet [
	| links shapes edges eb |
	links := self valueLinks.
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

{ #category : #'*Collections-Support-Visualizations' }
Link >> gtInspectorValueLinksChainGraphIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Links chain';
		  initializeCanvas: [ 
			  | aCanvas |
			  aCanvas := self gtInspectorValueLinksChainInCanvas: RSCanvas new.
			  aCanvas @ RSCanvasController ];
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> gtInspectorValueLinksChainInCanvas: aCanvas [
	^ aCanvas
		  addAll: (self asValueLinksGroupKnownReferences: IdentitySet empty);
		  yourself
]
