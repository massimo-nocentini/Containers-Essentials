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
LinkedList >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape |
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           firstLink ifNotNil: aStream |<| #nextPut:.
			           lastLink ifNotNil: aStream |<| #nextPut: ]).
	linksGroup := firstLink
		              ifNil: [ RSGroup new ]
		              ifNotNil: #asValueLinksGroup.
	linksComposite := linksGroup asShape.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: ({ 
				       (linksGroup shapeFromModel: firstLink).
				       (linksGroup shapeFromModel: lastLink) } reject: #isNil);
		      yourself.
	firstAndLastLinks := eb
		                     fromShapes: { 
				                     (aGroup shapeFromModel: firstLink).
				                     (aGroup shapeFromModel: lastLink) };
		                     useAssociations: { 
				                     firstLink asReflexiveAssociation.
				                     lastLink asReflexiveAssociation }.
	meShape := aGroup asShapeFor: self.
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
