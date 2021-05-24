Class {
	#name : #CTSlotsDfsTreeDrawer,
	#superclass : #Object,
	#instVars : [
		'visit',
		'fromShapes',
		'toShapes',
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsDfsTreeDrawer >> addAll: shapes onCanvas: aCanvas [

	aCanvas addAll: shapes.
	^ shapes
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [

	lineBuilder controlPointsController:
		self cpapControllerBezierDirected.

	^ backTuples collect: [ :aTuple | 
		  | edge |
		  edge := self edgeForTuple: aTuple lineBuilder: lineBuilder.
		  edge
			  dashArray: #( 1 );
			  yourself ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> cpapControllerBezierDirected [

	^ RSStartEndCPAPController new
		  controller: RSDirectedBezierCPAPController new;
		  startAttachPoint: RSCenteredAttachPoint new;
		  endAttachPoint: RSBorderAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> cpapControllerHorizontal [

	^ RSStartEndCPAPController new
		  controller: RSHorizontalCPAPController new;
		  startAttachPoint: RSCenteredAttachPoint new;
		  endAttachPoint: RSHorizontalEndBorderAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	lineBuilder controlPointsController:
		self cpapControllerBezierDirected.

	^ crossTuples collect: [ :aTuple | 
		  | edge |
		  edge := self edgeForTuple: aTuple lineBuilder: lineBuilder.
		  edge
			  dashArray: #( 4 );
			  yourself ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> drawOnCanvas: aCanvas [

	| metaColor lineBuilder shapes edges |
	metaColor := Color gray lighter lighter lighter.
	lineBuilder := RSLineBuilder bezier
		               canvas: aCanvas;
		               color: metaColor;
		               yourself.

	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	visit
		fromShapes: fromShapes;
		toShapes: toShapes;
		stronglyConnectedComponents: stronglyConnectedComponents;
		value.

	shapeBySCC := IdentityDictionary new.
	shapes := self addAll: toShapes values onCanvas: aCanvas.

	edges := self withDfsEdgesDo: [ 
		         :treeTuples 
		         :forwardTuples 
		         :backTuples 
		         :crossTuples | 
		         self
			         treeTuples: treeTuples lineBuilder: lineBuilder;
			         forwardTuples: forwardTuples lineBuilder: lineBuilder;
			         backTuples: backTuples lineBuilder: lineBuilder;
			         crossTuples: crossTuples lineBuilder: lineBuilder;
			         layoutTuples: treeTuples lineBuilder: RSLineBuilder line ].

	self layoutOn: shapes edges: edges.

	^ aCanvas
		  zoomToFit;
		  exportToSVG;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	^ lineBuilder
		  edgeFrom: aTuple propertyFromSlotShape
		  to: aTuple propertyToShape
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	lineBuilder controlPointsController:
		self cpapControllerBezierDirected.

	^ forwardTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> fromShape: fromShape toShape: toShape ifTree: tBlock ifForward: fBlock ifBack: bBlock ifCross: cBlock [

	^ fromShape == toShape
		  ifTrue: bBlock
		  ifFalse: [ 
			  | fromEntryTime toEntryTime fromLeaveTime toLeaveTime |
			  fromEntryTime := fromShape propertyDfsEntryTime.
			  toEntryTime := toShape propertyDfsEntryTime.
			  fromLeaveTime := fromShape propertyDfsLeaveTime.
			  toLeaveTime := toShape propertyDfsLeaveTime.

			  (fromEntryTime < toEntryTime and: [ 
				   toShape propertyDfsLeaveTime < fromLeaveTime ])
				  ifTrue: [ 
					  toShape propertyDfsDepth - fromShape propertyDfsDepth = 1
						  ifTrue: tBlock
						  ifFalse: fBlock ]
				  ifFalse: [ 
					  (toEntryTime < fromEntryTime and: [ 
						   fromLeaveTime < toLeaveTime ])
						  ifTrue: bBlock
						  ifFalse: [ 
							  toLeaveTime < fromEntryTime
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
CTSlotsDfsTreeDrawer >> layoutOn: shapes edges: edges [

	RSHorizontalVanDerPloegTreeLayout on: shapes edges: edges
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	| layoutAssociations |
	"Should be better to use an order-preserving dictionary for the sake of efficiency."
	layoutAssociations := Dictionary new.

	treeTuples do: [ :aTuple | 
		layoutAssociations
			at: aTuple propertyFromShape -> aTuple propertyToShape
			ifAbsentPut: [ layoutAssociations size + 1 ] ].

	layoutAssociations := layoutAssociations associations sorted: [ :a :b | 
		                      a value < b value ].

	^ layoutAssociations collect: [ :each | 
		  | anAssoc |
		  anAssoc := each key.
		  lineBuilder edgeFrom: anAssoc key to: anAssoc value ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	lineBuilder controlPointsController: self cpapControllerHorizontal.

	^ treeTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #accessing }
CTSlotsDfsTreeDrawer >> visit: anObject [

	visit := anObject
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
