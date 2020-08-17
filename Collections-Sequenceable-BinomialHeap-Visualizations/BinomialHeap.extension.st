Extension { #name : #BinomialHeap }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape associations associationsGroup associationsComposite associationsEdges valueLinks binomialTrees binomialTreesGroup treesEdges treesComposite |
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           representation ifNotNil: aStream |<| #nextPut: ]).
	valueLinks := representation
		              ifNil: [ Array empty ]
		              ifNotNil: #valueLinks.
	associations := valueLinks collect: #value.
	binomialTrees := associations collect: #value.
	linksGroup := representation
		              ifNil: [ RSGroup new ]
		              ifNotNil: [ :r | 
			              r asValueLinksGroupKnownReferences:
				              anIdentitySet | associations ].
	associationsGroup := (associations collect: [ :rankAndHeapAssoc | 
		                      ((rankAndHeapAssoc 
			                        asSlotsShapeKnownReferences:
			                        anIdentitySet | binomialTrees) asShapeFor:
			                       rankAndHeapAssoc) @ RSDraggable ]) as:
		                     RSGroup.
	binomialTreesGroup := binomialTrees
		                      collect: [ :aBinomialTree | 
			                      (aBinomialTree
				                       asRecursiveSlotsInGroup: RSGroup new
				                       knownReferencesSet: anIdentitySet) asShape
			                      @ RSDraggable ]
		                      as: RSGroup.
	RSVerticalLineLayout on: associationsGroup.
	RSVerticalLineLayout on: binomialTreesGroup.
	linksComposite := linksGroup asShape.
	associationsComposite := associationsGroup asShape.
	treesComposite := binomialTreesGroup asShape.
	meShape := aGroup asShapeFor: self.
	RSVerticalLineLayout new
		alignCenter;
		applyOn: { 
				meShape.
				linksComposite }.
	RSHorizontalLineLayout on: { 
			(RSComposite new
				 shapes: { 
						 meShape.
						 linksComposite };
				 yourself).
			associationsComposite.
			treesComposite }.
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
	treesEdges := eb
		              fromShapes: (associations collect: [ :anAssoc | 
					               (associationsGroup shapeFromModel: anAssoc) 
						               shapeFromModel: anAssoc value ]);
		              toShapes: binomialTreesGroup;
		              useAssociations:
			              (binomialTrees collect: #asReflexiveAssociation).
	^ (RSGroup new
		   add: meShape;
		   add: linksComposite;
		   add: associationsComposite;
		   add: treesComposite;
		   addAll: firstAndLastLinks;
		   addAll: associationsEdges;
		   addAll: treesEdges;
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
