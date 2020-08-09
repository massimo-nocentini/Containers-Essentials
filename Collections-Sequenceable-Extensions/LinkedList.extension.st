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
LinkedList >> asSlotsShape [
	| aGroup links firstAndLastLinks padding shapes edges eb chainShape meShape |
	padding := 5.
	links := Array streamContents: [ :aStream | 
		         | link |
		         link := firstLink.
		         [ link ] whileNotNil: [ 
			         aStream nextPut: link.
			         link := link nextLink ] ].
	aGroup := super asSlotsShapeKnownReferences:
		          (IdentitySet withAll: links). "to speed up the lookup."
	shapes := links collect: [ :aValueLink | 
		          | g |
		          g := aValueLink asSlotsShapeKnownReferences: links.
		          g asShapeFor: aValueLink ].
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: shapes;
		      yourself.
	edges := eb
		         fromShapes: (links
				          with: shapes
				          collect: [ :link :shape | 
					          shape shapeFromModel: link nextLink ]);
		         useAssociations: (links collect: [ :r | r -> r ]).
	firstAndLastLinks := eb
		                     fromShapes: { 
				                     (aGroup shapeFromModel: firstLink).
				                     (aGroup shapeFromModel: lastLink) };
		                     useAssociations: { 
				                     (firstLink -> firstLink).
				                     (lastLink -> lastLink) }.
	RSVerticalLineLayout on: shapes.
	chainShape := RSComposite new
		              shapes: shapes , edges;
		              padding: padding;
		              yourself.
	meShape := aGroup asShapeFor: self.
	RSLocation new outer left
		offset: padding negated;
		move: meShape on: chainShape.
	^ (RSGroup new
		   add: chainShape;
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
