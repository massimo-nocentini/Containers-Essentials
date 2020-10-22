Extension { #name : #Queue }

{ #category : #'*Collections-Sequenceable-Queue-Visualizations' }
Queue >> asSlotsGroupKnownReferences: anIdentitySet [
	| aGroup frontGroup rearGroup frontAndRearLinks frontComposite rearComposite eb composite meShape |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           front ifNotNil: [ aStream nextPut: front ].
			           rear ifNotNil: [ aStream nextPut: rear ] ]).
	frontGroup := front ifNil: [ RSGroup new ] ifNotNil: [ 
		              front
			              asSlotsGroupRecursiveKnownReferences: anIdentitySet
			              layoutBlock: [ :shapes | 
			              RSVerticalLineLayout on: shapes ] ].
	rearGroup := rear ifNil: [ RSGroup new ] ifNotNil: [ 
		             rear
			             asSlotsGroupRecursiveKnownReferences: anIdentitySet
			             layoutBlock: [ :shapes | 
			             RSVerticalLineLayout on: shapes ] ].
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
	RSHorizontalLineLayout on: { 
			frontComposite.
			rearComposite }.
	composite := RSComposite new
		             shapes: { 
				             frontComposite.
				             rearComposite };
		             yourself.
	meShape := aGroup asShapeFor: self.
	RSVerticalLineLayout new
		alignCenter;
		applyOn: { 
				meShape.
				composite }.
	^ (RSGroup new
		   add: meShape;
		   add: composite;
		   addAll: frontAndRearLinks;
		   yourself) @ RSDraggable
]
