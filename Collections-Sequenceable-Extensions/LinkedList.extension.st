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
	| aGroup firstAndLastLinks linksComposite linksGroup meShape eb |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet | (firstLink ifNil: [ {  } ] ifNotNil: [ 
			           { 
				           firstLink.
				           lastLink } ]).
	linksGroup := firstLink ifNil: [ RSGroup new ] ifNotNil: [ :r | 
		              r
			              asSlotsGroupRecursiveKnownReferences:
			              IdentitySet empty
			              layoutBlock: [ :shapes | 
			              RSVerticalLineLayout on: shapes ] ].
	firstAndLastLinks := RSEdgeBuilder arrowedLine
		                     color: Color gray;
		                     toShapes: ({ 
				                      (linksGroup shapeFromModel: firstLink).
				                      (linksGroup shapesFromModel: lastLink) } 
				                      reject: #isNil);
		                     fromShapes: { 
				                     (aGroup shapeFromModel: firstLink).
				                     (aGroup first shapes last shapeFromModel:
						                      lastLink) };
		                     useAssociations: { 
				                     firstLink asReflexiveAssociation.
				                     lastLink asReflexiveAssociation }.
	self size = 1 ifTrue: [ "Handle the special case when `firstLink` and `lastLink` points to 
		 the same ValueLink (aka, the list contains just one element)."
		| lastEdge |
		lastEdge := RSEdgeBuilder arrowedLine
			            color: Color gray;
			            toShapes: { (linksGroup shapeFromModel: firstLink) };
			            fromShapes:
				            { (aGroup first shapes last shapeFromModel: lastLink) };
			            useAssociation: lastLink asReflexiveAssociation.
		firstAndLastLinks add: lastEdge ].
	meShape := aGroup asShapeFor: self.
	linksComposite := linksGroup asShape.
	RSLocation new outer left
		offset: 5 negated;
		move: meShape on: linksComposite.
	^ (RSGroup new
		   add: linksComposite;
		   add: meShape;
		   addAll: firstAndLastLinks;
		   yourself) @ RSDraggable
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
