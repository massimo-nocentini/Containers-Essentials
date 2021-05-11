Class {
	#name : #CTSlotsDfsTreeDrawer,
	#superclass : #CTSlotsDrawer,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> drawOnCanvas: aCanvas [

	| fromShapes toShapes shapesAssociations layoutAssociations edges eb |
	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.

	visit
		fromShapes: fromShapes;
		toShapes: toShapes;
		value.

	aCanvas addAll: toShapes values.

	layoutAssociations := Dictionary new.
	shapesAssociations := OrderedCollection new.

	(fromShapes associations sorted: [ :anAssoc :anotherAssoc | 
		 (toShapes at: anAssoc key model) propertyDfsEntryTime
		 < (toShapes at: anotherAssoc key model) propertyDfsEntryTime ]) 
		do: [ :anAssociation | 
			| boxShape boxParentShape toShape |
			boxShape := anAssociation key.
			boxParentShape := anAssociation value.
			toShape := toShapes at: boxShape model.
			shapesAssociations add: boxShape -> toShape.

			(toShape propertyDfsDepth - boxParentShape propertyDfsDepth = 1 
				 and: [ 
					 boxParentShape propertyDfsEntryTime
					 < toShape propertyDfsEntryTime and: [ 
						 toShape propertyDfsLeaveTime
						 < boxParentShape propertyDfsLeaveTime ] ]) ifTrue: [ 
				layoutAssociations
					at: boxParentShape -> toShape
					ifAbsentPut: [ layoutAssociations size + 1 ] ] ].

	"This will add edges directly to the canvas."
	(RSLineBuilder new: self lineShape)
		canvas: aCanvas;
		useElementAssociations: shapesAssociations.

	aCanvas edges do: [ :edge | 
		| fromShape toShape |
		edge color: edge color lighter lighter lighter.

		fromShape := fromShapes at: edge from.
		toShape := edge to.
		(toShape propertyDfsEntryTime < fromShape propertyDfsEntryTime and: [ 
			 fromShape propertyDfsLeaveTime < toShape propertyDfsLeaveTime ])
			ifTrue: [ edge dashArray: #( 4 ) ]
			ifFalse: [ 
				toShape propertyDfsLeaveTime < fromShape propertyDfsEntryTime 
					ifTrue: [ edge dashArray: #( 1 ) ] ] ].

	eb := RSLineBuilder line.
	edges := (layoutAssociations associations sorted: [ 
		          :anAssociation 
		          :anotherAssociation | 
		          anAssociation value < anotherAssociation value ]) 
		         collect: [ :aNestedAssociation | 
			         | anAssociation |
			         anAssociation := aNestedAssociation key.
			         eb edgeFrom: anAssociation key to: anAssociation value ].

	RSHorizontalTreeLayout on: aCanvas nodes edges: edges.

	^ aCanvas
		  exportToSVG;
		  yourself
]
