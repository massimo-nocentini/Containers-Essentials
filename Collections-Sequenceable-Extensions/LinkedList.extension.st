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
	| aGroup links firstAndLastLinks lastShape canvas aLink anotherLink shapes edges eb chainShape composite |
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
		          (g asShapeFor: aValueLink) draggable ].
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      yourself.
	edges := eb
		         fromShapes: (links
				          with: shapes
				          collect: [ :link :shape | 
					          shape shapeFromModel: link nextLink ]);
		         toShapes: shapes;
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
		              padding: 5;
		              withBorder;
		              yourself.
	composite := RSComposite new
		             shapes: { 
				             (aGroup asShapeFor: self).
				             chainShape } , firstAndLastLinks;
		             draggable;
		             yourself.
	^ (RSGroup new
		   add: composite;
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
