Class {
	#name : #CTSlotsDfsTreeDrawer,
	#superclass : #Object,
	#instVars : [
		'visit',
		'fromShapes',
		'toShapes',
		'shapes',
		'levels',
		'oneToManyShapes'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> backLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  dotted;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSVerticalAttachPoint new);
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [

	^ backTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> crossLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  dashed;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSBottomEndVerticalAttachPoint new);
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	^ crossTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	^ lineBuilder
		  edgeFrom: aTuple propertyFromSlotShape
		  to: (aTuple propertyToShape propertyDfsBoxedSlotsShape ifNil: [ 
				   aTuple propertyToShape ])
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> forwardLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSHorizontalAttachPoint new);
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

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
CTSlotsDfsTreeDrawer >> layoutLinesBuilder [

	^ RSLineBuilder line
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSHorizontalVanDerPloegTreeLayout
		on: aCollectionOfShapes
		edges: aCollectionOfLines
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

{ #category : #adding }
CTSlotsDfsTreeDrawer >> shapes: aCollection [

	^ aCollection reject: [ :each | 
		  oneToManyShapes includesKey: each model ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> treeLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder polyline
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    cornerRadii: Float goldenRatio;
						    color: color;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  cornerRadii: Float goldenRatio double;
		  attachPoint: (RSHorizontalAttachPoint new
				   startOffset: Float goldenRatio double double negated;
				   yourself);
		  controlPointsController:
		  RSHorizontalGoldenRatioOffsetCPAPController new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	^ treeTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTSlotsDfsTreeDrawer >> visit [

	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.
	oneToManyShapes := IdentityDictionary new.
	levels := Dictionary new.

	visit
		fromShapes: fromShapes;
		toShapes: toShapes;
		levels: levels;
		oneToManyShapes: oneToManyShapes;
		value
]

{ #category : #accessing }
CTSlotsDfsTreeDrawer >> visit: anObject [

	| edges edgesForLayout |
	visit := anObject.

	self visit.

	shapes := self shapes: toShapes values.
	edges := OrderedCollection new.

	edgesForLayout := self withDfsEdgesDo: [ 
		                  :treeTuples 
		                  :forwardTuples 
		                  :backTuples 
		                  :crossTuples | 
		                  edges
			                  addAll:
				                  (self
					                   treeTuples: treeTuples
					                   lineBuilder: self treeLinesBuilder);
			                  addAll:
				                  (self
					                   forwardTuples: forwardTuples
					                   lineBuilder: self forwardLinesBuilder);
			                  addAll:
				                  (self
					                   backTuples: backTuples
					                   lineBuilder: self backLinesBuilder);
			                  addAll:
				                  (self
					                   crossTuples: crossTuples
					                   lineBuilder: self crossLinesBuilder).

		                  self
			                  layoutTuples: treeTuples
			                  lineBuilder: self layoutLinesBuilder ].

	self layoutOn: shapes edges: edgesForLayout.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
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
		| value boxShape fromShape manyShapes tuple tuples isOneToMany |
		boxShape := anAssociation key.
		fromShape := anAssociation value.

		value := boxShape model.

		manyShapes := oneToManyShapes
			              at: value
			              ifPresent: [ :someShapes | 
				              isOneToMany := true.
				              someShapes ]
			              ifAbsent: [ 
				              isOneToMany := false.
				              { (toShapes at: value) } ].

		manyShapes do: [ :toShape | 
			tuple := Array
				         with: index
				         with: boxShape
				         with: fromShape
				         with: toShape.

			tuples := self
				          fromShape: fromShape
				          toShape: toShape
				          ifTree: [ treeAssociations ]
				          ifForward: [ 
					          isOneToMany
						          ifTrue: [ treeAssociations ]
						          ifFalse: [ forwardAssociations ] ]
				          ifBack: [ backAssociations ]
				          ifCross: [ crossAssociations ].

			(shapes includes: fromShape) ifTrue: [ tuples add: tuple ] ] ].

	^ recvBlock
		  value: treeAssociations
		  value: forwardAssociations
		  value: backAssociations
		  value: crossAssociations
]
