Extension { #name : #BinomialHeap }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape associations associationsGroup associationsComposite associationsEdges valueLinks |
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           representation ifNotNil: aStream |<| #nextPut: ]).
	valueLinks := representation valueLinks.
	associations := valueLinks collect: #value.
	linksGroup := representation
		              ifNil: [ RSGroup new ]
		              ifNotNil: [ :r | 
			              r asValueLinksGroupKnownReferences:
				              anIdentitySet | associations ].
	associationsGroup := (associations collect: [ :rankAndHeapAssoc | 
		                      ((rankAndHeapAssoc 
			                        asSlotsShapeKnownReferences:
			                        IdentitySet new) asShapeFor:
			                       rankAndHeapAssoc) @ RSDraggable ]) as:
		                     RSGroup.
	RSVerticalLineLayout on: associationsGroup.
	linksComposite := linksGroup asShape.
	associationsComposite := associationsGroup asShape.
	meShape := aGroup asShapeFor: self.
	RSLocation new outer left middle
		offset: 10 negated;
		move: linksComposite on: associationsComposite.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes:
			      ({ (linksGroup shapeFromModel: representation) } reject:
					       #isNil);
		      yourself.
	firstAndLastLinks := eb
		                     fromShapes:
			                     { (aGroup shapeFromModel: representation) };
		                     useAssociations:
			                     { representation asReflexiveAssociation }.
	associationsEdges := eb
		                     fromShapes:
			                     (valueLinks collect: [ :aValueLink | 
					                      (linksGroup shapeFromModel: aValueLink) 
						                      shapeFromModel: aValueLink value ]);
		                     toShapes: associationsGroup;
		                     useAssociations:
			                     (associations collect: #asReflexiveAssociation).
	RSLocation new outer above
		offset: 10 negated;
		move: meShape on: linksComposite.
	^ (RSGroup new
		   add: linksComposite;
		   add: associationsComposite;
		   add: meShape;
		   addAll: firstAndLastLinks;
		   addAll: associationsEdges;
		   yourself) @ RSDraggable
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> associations [
	^ self associations: representation
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> associations: aValueLink [
	^ aValueLink
		ifNotNil: [ aValueLink value ~~> (self associations: aValueLink nextLink) ]
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> gtInspectorTreesUsingMondrianBuilder: aMondrian [
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray;
		withTextAbove: #key.
	aMondrian
		nodes: self associations asLinkedList
		forEach:
			[ :anAssociation | anAssociation value gtInspectorTreeUsingMondrianBuilder: aMondrian ].
	aMondrian layout verticalLine
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>

]
