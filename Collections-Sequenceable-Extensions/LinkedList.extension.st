Extension { #name : #LinkedList }

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> , other [
	"Optimized version of append for this specific linked container"

	^ other
		ifEmpty: [ self ]
		ifNotEmpty: [ self
				addLast: other firstLink;
				yourself ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> allButFirst [
	^ self cdr
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> asSlotsGroupKnownReferences: anIdentitySet [

	| selfGroup |
	selfGroup := firstLink
		             ifNil: [ 
			             | aShape |
			             aShape := (super asSlotsGroupKnownReferences:
				                        anIdentitySet) asShapeFor: self.

			             RSGroup new
				             add: aShape;
				             yourself ]
		             ifNotNil: [ 
			             | aGroup linksComposite linksGroup meShape firstLinkLine lastLinkLine firstEdge lastEdge |
			             aGroup := super asSlotsGroupKnownReferences:
				                       anIdentitySet
				                       | (Array with: firstLink with: lastLink).

			             linksGroup := firstLink
				                           asSlotsGroupRecursiveKnownReferences:
				                           anIdentitySet
				                           layoutBlock: [ :shapes | 
				                           RSVerticalLineLayout on: shapes ].

			             meShape := aGroup asShapeFor: self.
			             linksComposite := linksGroup asShape.

			             RSLocation new outer middle left
				             offset: 5 negated;
				             move: meShape on: linksComposite.

			             firstLinkLine := firstLink 
				                              lineShapeWithControlPointsController:
				                              self
					                              firstLinkControlPointsController.
			             lastLinkLine := lastLink 
				                             lineShapeWithControlPointsController:
				                             self lastLinkControlPointsController.

			             firstEdge := (RSEdgeBuilder new: firstLinkLine)
				                          color: Color gray;
				                          toShapes:
					                          { (linksGroup shapeFromModel: firstLink) };
				                          fromShapes:
					                          { (aGroup first shapes first 
						                           shapeFromModel: firstLink) };
				                          useAssociation:
					                          firstLink asReflexiveAssociation.

			             lastEdge := (RSEdgeBuilder new: lastLinkLine)
				                         color: Color gray;
				                         toShapes:
					                         { (linksGroup shapeFromModel: lastLink) };
				                         fromShapes:
					                         { (aGroup first shapes last 
						                          shapeFromModel: lastLink) };
				                         useAssociation:
					                         lastLink asReflexiveAssociation.

			             RSGroup new
				             add: meShape;
				             add: linksComposite;
				             add: firstEdge;
				             add: lastEdge;
				             yourself ].

	^ selfGroup @ RSDraggable
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> car [
	"Return the very first element"

	^ self first
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> cdr [
	"Returns the tail of this list"

	^ self
		ifNotEmpty: [ firstLink nextLink
				ifNil: [ self class new ]
				ifNotNil: [ :nl | self class with: nl ] ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> firstLinkControlPointsController [

	^ RSBlockCPController new
		  block: [ :edge | 
			  | f t ap top offset |
			  ap := edge attachPoint.
			  f := ap startingPointOf: edge.
			  t := ap endingPointOf: edge.

			  offset := 5.
			  top := t y - (edge to height / 2) - offset.
			  Array
				  with: f
				  with: f x @ top
				  with: t x @ top
				  with: t ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> lastLinkControlPointsController [

	^ RSBlockCPController new
		  block: [ :edge | 
			  | f t ap bottom offset |
			  ap := edge attachPoint.
			  f := ap startingPointOf: edge.
			  t := ap endingPointOf: edge.

			  offset := 5.
			  bottom := t y + (edge to height / 2) + offset.
			  Array
				  with: f
				  with: f x @ bottom
				  with: t x @ bottom
				  with: t ];
		  yourself
]
