"
I am able to compose the final tree representation of outliners provided by `CTDfsVisitWalker`.
"
Class {
	#name : #CTDfsVisitPainter,
	#superclass : #Object,
	#instVars : [
		'visit',
		'fromShapes',
		'toShapes',
		'levels',
		'oneToManyShapes'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> backLinesBuilder [

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
CTDfsVisitPainter >> backTuples: backTuples lineBuilder: lineBuilder [

	^ backTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> crossLinesBuilder [

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
CTDfsVisitPainter >> crossTuples: crossTuples lineBuilder: lineBuilder [

	^ crossTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	^ lineBuilder
		  edgeFrom: aTuple propertyFromSlotShape
		  to: (aTuple propertyToShape propertyDfsBoxedSlotsShape ifNil: [ 
				   aTuple propertyToShape ])
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> forbiddenShapes: forbiddenShapes withDfsEdgesDo: recvBlock [

	| sortedFromShapes treeAssociations forwardAssociations backAssociations crossAssociations |
	treeAssociations := OrderedCollection new.
	forwardAssociations := OrderedCollection new.
	backAssociations := OrderedCollection new.
	crossAssociations := OrderedCollection new.

	sortedFromShapes := fromShapes associations sorted: [ 
		                    :anAssoc 
		                    :anotherAssoc | 
		                    | aTime anotherTime |
		                    aTime := (toShapes at: anAssoc key model)
			                             propertyDfsEntryTime.
		                    anotherTime := (toShapes at:
			                                    anotherAssoc key model)
			                                   propertyDfsEntryTime.
		                    aTime < anotherTime ].

	sortedFromShapes withIndexDo: [ :anAssociation :index | 
		| value boxShape fromShape manyShapes tuple tuples isOneToMany toShape |
		boxShape := anAssociation key.
		fromShape := anAssociation value.

		value := boxShape model.
		toShape := toShapes at: value.

		oneToManyShapes
			at: value
			ifPresent: [ :someShapes | 
				forbiddenShapes add: (toShapes at: value).
				isOneToMany := true.
				manyShapes := someShapes ]
			ifAbsent: [ 
				isOneToMany := false.
				manyShapes := Array with: (toShapes at: value) ].

		manyShapes do: [ :aShape | 
			tuple := Array
				         with: index
				         with: boxShape
				         with: fromShape
				         with: aShape.

			tuples := self
				          fromShape: fromShape
				          toShape: aShape
				          ifTree: [ treeAssociations ]
				          ifForward: [ 
					          isOneToMany
						          ifTrue: [ treeAssociations ]
						          ifFalse: [ forwardAssociations ] ]
				          ifBack: [ backAssociations ]
				          ifCross: [ crossAssociations ].

			(forbiddenShapes includes: fromShape) ifFalse: [ tuples add: tuple ] ] ].

	^ recvBlock
		  value: treeAssociations
		  value: forwardAssociations
		  value: backAssociations
		  value: crossAssociations
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> forwardLinesBuilder [

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
CTDfsVisitPainter >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	^ forwardTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> fromShape: fromShape toShape: toShape ifTree: tBlock ifForward: fBlock ifBack: bBlock ifCross: cBlock [

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
CTDfsVisitPainter >> layoutLinesBuilder [

	^ RSLineBuilder line
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSHorizontalVanDerPloegTreeLayout
		on: aCollectionOfShapes
		edges: aCollectionOfLines
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

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
CTDfsVisitPainter >> shapes: aCollection [

	^ aCollection
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> treeLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder polyline
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    cornerRadii: Float goldenRatio;
						    color: color;
						    yourself);
				   offset: Float goldenRatio;
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
CTDfsVisitPainter >> treeTuples: treeTuples lineBuilder: lineBuilder [

	^ treeTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : #'as yet unclassified' }
CTDfsVisitPainter >> visit [

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
CTDfsVisitPainter >> visit: anObject [

	| shapes edges edgesForLayout forbiddenShapes |
	visit := anObject.

	self visit.

	forbiddenShapes := IdentitySet new.
	shapes := self shapes: toShapes values.
	edges := OrderedCollection new.

	self
		forbiddenShapes: forbiddenShapes
		withDfsEdgesDo: [ :treeTuples :forwardTuples :backTuples :crossTuples | 
			edges
				addAll:
					(self treeTuples: treeTuples lineBuilder: self treeLinesBuilder);
				addAll: (self
						 forwardTuples: forwardTuples
						 lineBuilder: self forwardLinesBuilder);
				addAll:
					(self backTuples: backTuples lineBuilder: self backLinesBuilder);
				addAll:
					(self
						 crossTuples: crossTuples
						 lineBuilder: self crossLinesBuilder).

			edgesForLayout := self
				                  layoutTuples: treeTuples
				                  lineBuilder: self layoutLinesBuilder ].

	shapes := shapes reject: [ :each | forbiddenShapes includes: each ].

	self layoutOn: shapes edges: edgesForLayout.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
]
