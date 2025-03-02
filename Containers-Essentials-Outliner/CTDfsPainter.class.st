"
I am able to compose the final tree representation of outliners provided by `CTDfsVisitWalker`.
"
Class {
	#name : 'CTDfsPainter',
	#superclass : 'Object',
	#instVars : [
		'fromShapes',
		'toShapes',
		'levels',
		'shapes',
		'edges',
		'dfsWalker',
		'layout',
		'skipBoxes'
	],
	#category : 'Containers-Essentials-Outliner-Painters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Painters'
}

{ #category : 'line building' }
CTDfsPainter >> backLinesBuilder [

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

{ #category : 'line drawing' }
CTDfsPainter >> backTuples: backTuples lineBuilder: lineBuilder [

	^ backTuples collect: [ :aTuple |
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : 'line building' }
CTDfsPainter >> crossLinesBuilder [

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

{ #category : 'line drawing' }
CTDfsPainter >> crossTuples: crossTuples lineBuilder: lineBuilder [

	^ crossTuples collect: [ :aTuple |
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : 'DFS' }
CTDfsPainter >> dfsWalk: anObject [

	| aShape |
	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.
	levels := Dictionary new.

	aShape := dfsWalker
		          fromShapes: fromShapes;
		          toShapes: toShapes;
		          levels: levels;
		          value: anObject.

	^ toShapes values
]

{ #category : 'accessing' }
CTDfsPainter >> dfsWalker: aWalker [

	dfsWalker := aWalker
]

{ #category : 'line drawing' }
CTDfsPainter >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	| fromShape toShape |
	fromShape := aTuple propertyFromSlotShape.
	fromShape propertyDfsBoxedSlotsShape ifNotNil: [ :boxedShape | 
		fromShape := boxedShape ].

	toShape := aTuple propertyToShape.
	toShape propertyDfsBoxedSlotsShape ifNotNil: [ :boxedShape | 
		toShape := boxedShape ].

	^ lineBuilder edgeFrom: fromShape to: toShape
]

{ #category : 'line building' }
CTDfsPainter >> forwardLinesBuilder [

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

{ #category : 'line drawing' }
CTDfsPainter >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	^ forwardTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : 'mapping' }
CTDfsPainter >> fromShape: fromShape toShape: toShape ifTree: tBlock ifForward: fBlock ifBack: bBlock ifCross: cBlock ifPost: pBlock [

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
								  ifFalse: pBlock ] ] ]
]

{ #category : 'initialization' }
CTDfsPainter >> initialize [

	super initialize.

	skipBoxes := IdentitySet new.

	self layout:
		RSHorizontalWithChildrenSizeDepthsVanDerPloegTreeLayout new
]

{ #category : 'initialization' }
CTDfsPainter >> layout: aLayout [

	layout := aLayout
]

{ #category : 'line building' }
CTDfsPainter >> layoutLinesBuilder [

	^ RSLineBuilder line
]

{ #category : 'layouting' }
CTDfsPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	layout on: aCollectionOfShapes edges: aCollectionOfLines
]

{ #category : 'line drawing' }
CTDfsPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

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

{ #category : 'line building' }
CTDfsPainter >> newTreeLine [

	^ RSLineBuilder horizontalDeCasteljauSegmentedLine "Or horizontalSegmentedBezierLine"
]

{ #category : 'line building' }
CTDfsPainter >> postLinesBuilder [

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
		  color: color lighter;
		  dashArray: { (4 * Float silverRatio) };
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSTopEndVerticalAttachPoint new);
		  yourself
]

{ #category : 'line building' }
CTDfsPainter >> postSharingLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  "markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);"
		  color: color lighter;
		  dashArray: { (4 * Float silverRatio) };
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSCenteredAttachPoint new);
		  yourself
]

{ #category : 'line drawing' }
CTDfsPainter >> postTuples: postTuples lineBuilder: lineBuilder [

	^ postTuples collect: [ :aTuple |
		  dfsWalker postponedObjects
			  at: aTuple second
			  ifPresent: [ :anAssoc |
				  | toShape boxes toObject parent toBox newTuple |
				  parent := anAssoc key.
				  toObject := anAssoc value.

				  toShape := toShapes at: toObject.
				  boxes := toShape propertyDfsWalkingData rows collect: #box.

				  toBox := boxes detect: [ :each | each model == parent ].

				  skipBoxes add: toBox.

				  newTuple := aTuple copy
					              at: 4 put: toBox;
					              yourself.

				  self
					  edgeForTuple: newTuple
					  lineBuilder: self postSharingLinesBuilder ]
			  ifAbsent: [ self edgeForTuple: aTuple lineBuilder: lineBuilder ] ]
]

{ #category : 'iterating' }
CTDfsPainter >> sortedFromShapes [

	^ fromShapes associations sorted: [ :anAssoc :anotherAssoc |
		  | aTime anotherTime |
		  aTime := (toShapes at: anAssoc key model) propertyDfsEntryTime.

		  anotherTime := (toShapes at: anotherAssoc key model)
			                 propertyDfsEntryTime.

		  aTime < anotherTime ]
]

{ #category : 'line building' }
CTDfsPainter >> treeLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.

	^ self newTreeLine
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
				   endOffset: Float goldenPlatinumRatio negated;
				   yourself);
		  yourself
]

{ #category : 'line drawing' }
CTDfsPainter >> treeTuples: treeTuples lineBuilder: lineBuilder [

	^ treeTuples collect: [ :aTuple | 
		  self edgeForTuple: aTuple lineBuilder: lineBuilder ]
]

{ #category : 'API' }
CTDfsPainter >> value: anObject [

	| edgesForLayout |
	edges := OrderedCollection new.
	shapes := self dfsWalk: anObject.

	self withDfsEdgesDo: [
		:treeTuples
		:forwardTuples
		:backTuples
		:crossTuples
		:postTuples |
		edges
			addAll:
				(self treeTuples: treeTuples lineBuilder: self treeLinesBuilder);
			addAll: (self
					 forwardTuples: forwardTuples
					 lineBuilder: self forwardLinesBuilder);
			addAll:
				(self backTuples: backTuples lineBuilder: self backLinesBuilder);
			addAll:
				(self crossTuples: crossTuples lineBuilder: self crossLinesBuilder);
			addAll:
				(self postTuples: postTuples lineBuilder: self postLinesBuilder).

		edgesForLayout := self
			                  layoutTuples: treeTuples
			                  lineBuilder: self layoutLinesBuilder ].

	edges := edges reject: [ :each | skipBoxes includes: each from ].

	self layoutOn: shapes edges: edgesForLayout.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
]

{ #category : 'enumerating' }
CTDfsPainter >> withDfsEdgesDo: recvBlock [

	| treeAssociations forwardAssociations backAssociations crossAssociations postAssociations |
	treeAssociations := OrderedCollection new.
	forwardAssociations := OrderedCollection new.
	backAssociations := OrderedCollection new.
	crossAssociations := OrderedCollection new.
	postAssociations := OrderedCollection new.

	self sortedFromShapes withIndexDo: [ :anAssociation :index |
		| boxShape fromShape tuple tuples isOneToMany mapped aShape |
		boxShape := anAssociation key.
		fromShape := anAssociation value.

		aShape := toShapes at: boxShape model.

		boxShape
			propertyAt: #isGhostShape
			ifPresent: [ boxShape := fromShape ].

		"Check if we are in the presence of a one-to-many description,
		 have a look at corresponding comments in `CTDfsWalker>>#recurring:`."
		mapped := dfsWalker oneToManyAt: boxShape.

		(isOneToMany := mapped isAssociation) ifTrue: [
			boxShape := mapped key.
			fromShape := mapped value ].

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
			          ifCross: [ crossAssociations ]
			          ifPost: [ postAssociations ].

		tuples add: tuple ].

	^ recvBlock valueWithArguments: {
			  treeAssociations.
			  forwardAssociations.
			  backAssociations.
			  crossAssociations.
			  postAssociations }
]
