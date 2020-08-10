Extension { #name : #Queue }

{ #category : #'*Collections-Sequenceable-Queue-Visualizations' }
Queue >> asSlotsShapeKnownReferences: anIdentitySet [
	| aGroup frontGroup rearGroup frontAndRearLinks padding frontComposite rearComposite eb composite meShape |
	padding := 5.
	aGroup := super asSlotsShapeKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           front ifNotNil: [ aStream nextPut: front ].
			           rear ifNotNil: [ aStream nextPut: rear ] ]).
	frontGroup := front
		              ifNil: [ RSGroup new ]
		              ifNotNil: #asValueLinksGroup.
	rearGroup := rear ifNil: [ RSGroup new ] ifNotNil: #asValueLinksGroup.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: ({ 
				       (frontGroup shapeFromModel: front).
				       (rearGroup shapeFromModel: rear) } reject: #isNil);
		      yourself.
	frontAndRearLinks := eb
		                     fromShapes: { 
				                     (aGroup shapeFromModel: front).
				                     (aGroup shapeFromModel: rear) };
		                     useAssociations: { 
				                     front asReflexiveAssociation.
				                     rear asReflexiveAssociation }.
	frontComposite := frontGroup asShapeFor: front.
	rearComposite := rearGroup asShapeFor: rear.
	RSLocation new left outer
		offset: padding negated;
		move: frontComposite on: rearComposite.
	RSAlignment new
		shapes: { 
				frontComposite.
				rearComposite };
		top.
	composite := RSComposite new
		             padding: padding;
		             shapes: { 
				             frontComposite.
				             rearComposite };
		             yourself.
	meShape := aGroup asShapeFor: self.
	RSLocation new above
		offset: padding negated;
		move: meShape on: composite.
	^ (RSGroup new
		   add: composite;
		   add: meShape;
		   addAll: frontAndRearLinks;
		   yourself) @ RSDraggable
]
