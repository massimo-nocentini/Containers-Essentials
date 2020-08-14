Extension { #name : #BinomialHeap }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape |
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           representation ifNotNil: aStream |<| #nextPut: ]).
	linksGroup := representation
		              ifNil: [ RSGroup new ]
		              ifNotNil: [ :r | 
		              r asValueLinksGroupKnownReferences: IdentitySet empty ].
	linksComposite := linksGroup asShape.
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
	meShape := aGroup asShapeFor: self.
	RSLocation new outer above
		offset: 10 negated;
		move: meShape on: linksComposite.
	^ (RSGroup new
		   add: linksComposite;
		   add: meShape;
		   addAll: firstAndLastLinks;
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
