Class {
	#name : #CTSlotsDfsTreeDrawer,
	#superclass : #CTSlotsDrawer,
	#instVars : [
		'fromShapes',
		'toShapes'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> associationsForTreeLayoutingShapes: treeTuples thenCollect: aBlock [

	| layoutAssociations |
	"Should be better to use an order-preserving dictionary for the sake of efficiency."
	layoutAssociations := Dictionary new.

	treeTuples do: [ :aTuple | 
		layoutAssociations
			at: aTuple propertyFromShape -> aTuple propertyToShape
			ifAbsentPut: [ layoutAssociations size + 1 ] ].

	layoutAssociations := layoutAssociations associations sorted: [ :a :b | 
		                      a value < b value ].

	^ layoutAssociations collect: [ :each | aBlock value: each key ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> drawOnCanvas: aCanvas [

	| metaColor |
	metaColor := Color gray lighter lighter lighter.

	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.

	visit
		fromShapes: fromShapes;
		toShapes: toShapes;
		value.

	aCanvas addAll: toShapes values.

	self withDfsEdgesDo: [ :treeTuples :forwardTuples :backTuples :crossTuples | 
		| edges lineBuilder |
		lineBuilder := (RSLineBuilder new: self bezierShape)
			               canvas: aCanvas;
			               yourself.

		treeTuples do: [ :aTuple | 
			| edge |
			edge := lineBuilder
				        edgeFrom: aTuple propertyFromSlotShape
				        to: aTuple propertyToShape.
			edge color: metaColor ].

		forwardTuples do: [ :aTuple | 
			| edge |
			edge := lineBuilder
				        edgeFrom: aTuple propertyFromSlotShape
				        to: aTuple propertyToShape.
			edge
				color: metaColor;
				dashArray: #( 2 ) ].

		backTuples do: [ :aTuple | 
			| edge |
			edge := lineBuilder
				        edgeFrom: aTuple propertyFromSlotShape
				        to: aTuple propertyToShape.
			edge
				color: metaColor;
				dashArray: #( 1 ) ].

		crossTuples do: [ :aTuple | 
			| edge |
			edge := lineBuilder
				        edgeFrom: aTuple propertyFromSlotShape
				        to: aTuple propertyToShape.
			edge
				color: metaColor;
				dashArray: #( 4 ) ].

		lineBuilder := RSLineBuilder line.
		edges := self
			         associationsForTreeLayoutingShapes: treeTuples
			         thenCollect: [ :anAssociation | 
				         lineBuilder
					         edgeFrom: anAssociation key
					         to: anAssociation value ].

		RSHorizontalTreeLayout on: aCanvas nodes edges: edges ].

	^ aCanvas
		  exportToSVG;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> fromShape: fromShape toShape: toShape ifTree: tBlock ifForward: fBlock ifBack: bBlock ifCross: cBlock [

	^ fromShape == toShape
		  ifTrue: bBlock
		  ifFalse: [ 
			  (fromShape propertyDfsEntryTime < toShape propertyDfsEntryTime 
				   and: [ 
				   toShape propertyDfsLeaveTime < fromShape propertyDfsLeaveTime ])
				  ifTrue: [ 
					  toShape propertyDfsDepth - fromShape propertyDfsDepth = 1
						  ifTrue: tBlock
						  ifFalse: fBlock ]
				  ifFalse: [ 
					  (toShape propertyDfsEntryTime < fromShape propertyDfsEntryTime 
						   and: [ 
						   fromShape propertyDfsLeaveTime < toShape propertyDfsLeaveTime ])
						  ifTrue: bBlock
						  ifFalse: [ 
							  toShape propertyDfsLeaveTime < fromShape propertyDfsEntryTime
								  ifTrue: cBlock
								  ifFalse: [ 
									  Error signal:
										  'Logical inconsistency: a non-sense association has been recognized.' ] ] ] ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> fromShapesDfsSortBlock [

	^ [ :anAssoc :anotherAssoc | 
	  | aSlotBox anotherSlotBox aTime anotherTime |
	  aSlotBox := anAssoc key.
	  anotherSlotBox := anotherAssoc key.
	  aTime := (toShapes at: aSlotBox model) propertyDfsEntryTime.
	  anotherTime := (toShapes at: anotherSlotBox model)
		                 propertyDfsEntryTime.
	  aTime < anotherTime ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> withDfsEdgesDo: recvBlock [

	| sortedFromShapes treeAssociations forwardAssociations backAssociations crossAssociations |
	treeAssociations := OrderedCollection new.
	forwardAssociations := OrderedCollection new.
	backAssociations := OrderedCollection new.
	crossAssociations := OrderedCollection new.

	sortedFromShapes := fromShapes associations sorted:
		                    self fromShapesDfsSortBlock.

	sortedFromShapes withIndexDo: [ :anAssociation :index | 
		| boxShape fromShape toShape tuple tuples |
		boxShape := anAssociation key.
		fromShape := anAssociation value.
		toShape := toShapes at: boxShape model.

		tuple := Array
			         with: index
			         with: boxShape
			         with: fromShape
			         with: toShape.

		tuples := self
			          fromShape: fromShape
			          toShape: toShape
			          ifTree: [ treeAssociations ]
			          ifForward: [ forwardAssociations ]
			          ifBack: [ backAssociations ]
			          ifCross: [ crossAssociations ].

		tuples add: tuple ].

	^ recvBlock
		  value: treeAssociations
		  value: forwardAssociations
		  value: backAssociations
		  value: crossAssociations
]
