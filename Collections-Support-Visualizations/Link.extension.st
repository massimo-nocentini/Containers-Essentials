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

	| shapes aNewSet edges pointsController line |
	aNewSet := aSet | links.
	shapes := links collect: [ :aValueLink | 
		          | g |
		          g := aValueLink asSlotsGroupKnownReferences: aNewSet.
		          (g asShapeFor: aValueLink) @ RSDraggable ].
	pointsController := self 
		                    loopingBackwardControlPointsControllerOverShapes:
		                    shapes.
	line := self lineShapeWithControlPointsController: pointsController.
	edges := self
		         edgesConnectingShapes: shapes
		         references: links
		         lineShape: line
		         modelBlock: [ :link | link nextLink ].
	lBlock cull: shapes cull: edges.
	^ RSGroup new
		  addAll: shapes;
		  addAll: edges;
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> asSlotsGroupRecursiveKnownReferences: aSet [
	"This message should be overridden by any subclass that has a recursive structure
	 that would be visualized; in particular, the layout block has to be plugged in."

	^ self
		  asSlotsGroupRecursiveKnownReferences: aSet
		  layoutBlock: [ :shapes | RSVerticalLineLayout on: shapes ]
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> edgesConnectingShapes: shapes references: links lineShape: line modelBlock: mBlock [

	| fromShapes |
	fromShapes := links with: shapes collect: [ :link :shape | 
		              | model |
		              model := mBlock value: link.
		              shape deepShapeFromModel: model ].
	fromShapes := fromShapes reject: [ :each | each model isNil ].
	^ (RSEdgeBuilder new: line)
		  color: Color gray;
		  toShapes: shapes;
		  fromShapes: fromShapes;
		  useAssociations:
			  (links collect: [ :r | r asReflexiveAssociation ])
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> instVarsNamesOrderedCollection [

	^ Array with: #nextLink -> [ :anObj | anObj nextLink ]
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> lineShapeWithControlPointsController: aController [

	| controller |
	controller := RSStartEndCPAPController new
		              controller: RSDirectedBezierCPAPController new;
		              startAttachPoint: RSCenteredAttachPoint new;
		              endAttachPoint: RSBorderAttachPoint new;
		              yourself.
	^ RSPolyline new
		  border: (RSBorder new width: 1);
		  cornerRadii: 2;
		  markerEnd: RSArrowedLine new defaultHead asMarker;
		  controlPointsController: aController;
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
Link >> loopingBackwardControlPointsControllerOverShapes: shapes [

	^ RSBlockCPController new
		  block: [ :edge | 
			  | f t ap |
			  ap := edge attachPoint.
			  f := RSCenteredAttachPoint new startingPointOf: edge.
			  t := RSBorderAttachPoint new endingPointOf: edge.
			  edge to == shapes first
				  ifTrue: [ 
					  | top bottom left offset |
					  offset := 5.
					  bottom := shapes last encompassingRectangle bottom + offset.
					  top := shapes first encompassingRectangle top - offset double.
					  left := shapes last encompassingRectangle left - offset.
					  Array
						  with: f
						  with: f x @ bottom
						  with: left @ bottom
						  with: left @ top
						  with: t x / 2 @ top
						  with: t x / 2 @ (top + offset double) ]
				  ifFalse: [ Array with: f with: t ] ];
		  yourself
]
