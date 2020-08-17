Extension { #name : #BinomialTree }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape |
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           children ifNotNil: aStream |<| #nextPut: ]).
	linksGroup := children
		              ifNil: [ RSGroup new ]
		              ifNotNil: [ :r | 
		              r asValueLinksGroupKnownReferences: anIdentitySet ].
	linksComposite := linksGroup asShape.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes:
			      ({ (linksGroup shapeFromModel: children) } reject: #isNil);
		      yourself.
	firstAndLastLinks := eb
		                     fromShapes:
			                     { (aGroup shapeFromModel: children) };
		                     useAssociations:
			                     { children asReflexiveAssociation }.
	meShape := aGroup asShapeFor: self.
	RSLocation new above outer
		offset: 10 negated;
		move: meShape on: linksComposite.
	^ (RSGroup new
		   add: linksComposite;
		   add: meShape;
		   addAll: firstAndLastLinks;
		   yourself) @ RSDraggable
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges [
	^ self edges: content -> content ~~> nil
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges: incomingEdges [
	^ children asLinkedList
		foldr: [ :each :acc | each edges: content -> each content ~~> acc ]
		init: incomingEdges
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> gtInspectorTreeUsingMondrianBuilder: aMondrian [
	self edges asLinkedList asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: #content;
				color: Color black ]
		edge: [ :shape | shape orthoVerticalLine ]
		layout: #tree
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> instVarsNamesOrderedCollection [
	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ #( children content )
]
