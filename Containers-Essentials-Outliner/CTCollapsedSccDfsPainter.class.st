"
I am a variant that shows a tree of strongly connected components and, by double-click, I expand the clicked one.
"
Class {
	#name : #CTCollapsedSccDfsPainter,
	#superclass : #CTBaseSccDfsPainter,
	#instVars : [
		'associations',
		'outgoingEdges',
		'treeTuples',
		'treeEdgeBuilder',
		'layoutLineBuilder'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> backTuples: backTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := self liftTuples: backTuples.

	self assert: tuples isEmpty.

	^ super backTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> cpapControllerBezierDirected [

	^ RSStartEndCPAPController new
		  controller: RSDirectedBezierCPAPController new;
		  startAttachPoint: RSHorizontalAttachPoint new;
		  endAttachPoint: RSBorderAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> cpapControllerHorizontal [

	^ RSStartEndCPAPController new
		  controller: RSHorizontalCPAPController new;
		  startAttachPoint: RSHorizontalAttachPoint  new;
		  endAttachPoint: RSHorizontalAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> crossTuples: crossTuples lineBuilder: lineBuilder [

	| tuples crossEdges |
	tuples := (self liftTuples: crossTuples) reject: [ :aTuple | 
		          associations includes:
			          aTuple propertyFromShape -> aTuple propertyToShape ].

	tuples do: [ :aTuple | 
		associations add: aTuple propertyFromShape -> aTuple propertyToShape ].

	crossEdges := super crossTuples: tuples lineBuilder: lineBuilder.

	outgoingEdges addAll: crossEdges.

	^ crossEdges
		  do: [ :anEdge | associations add: anEdge from -> anEdge to ];
		  yourself
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	^ lineBuilder
		  edgeFrom: aTuple propertyFromShape
		  to: aTuple propertyToShape
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> fixFromToShapesOfTuple: aTuple [

	| toSCCShape fromSCCShape |
	fromSCCShape := shapeBySCC at:
		                aTuple propertyFromShape propertyDfsSCC.

	toSCCShape := shapeBySCC at: aTuple propertyToShape propertyDfsSCC.

	^ aTuple copy
		  at: 3 put: fromSCCShape;
		  at: 4 put: toSCCShape;
		  yourself
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	^ super
		  forwardTuples: (self liftTuples: forwardTuples)
		  lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> layoutTuples: aCollection lineBuilder: lineBuilder [

	layoutLineBuilder := lineBuilder.
	^ super
		  layoutTuples: (self liftTuples: aCollection)
		  lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> liftTuples: tuples [

	^ tuples
		  collect: [ :aTuple | self fixFromToShapesOfTuple: aTuple ]
		  thenReject: [ :r | r propertyFromShape == r propertyToShape ]
]

{ #category : #adding }
CTCollapsedSccDfsPainter >> shapes: aCollection [

	| sccsShapes |
	sccsShapes := stronglyConnectedComponents collect: [ :aSCC | 
		              RSBox new
			              size: aSCC size sqrt * Float goldenRatio double;
			              color: Color white;
			              addInteraction:
				              (RSPopup new text: [ :aModel | aSCC size ]);
			              withBorder;
			              cornerRadius: Float goldenRatio double;
			              addInteraction: RSDraggable new;
			              when: RSMouseDoubleLeftClick do: [ :ev | 
				              | composite boxShape innerTreeTuples innerTreeEdges layoutEdges |
				              boxShape := ev shape.

				              composite := RSComposite new
					                           shapes: aSCC;
					                           yourself.

				              boxShape canvas add: composite.

				              innerTreeTuples := treeTuples select: [ :aTuple | 
					                                 aTuple propertyFromShape
						                                 propertyDfsSCC == aSCC ].

				              innerTreeEdges := innerTreeTuples collect: [ :aTuple | 
					                                | tup |
					                                tup := aTuple propertyFromShape
						                                       propertyDfsSCC
					                                       ==
					                                       aTuple propertyToShape
						                                       propertyDfsSCC
						                                       ifTrue: [ aTuple ]
						                                       ifFalse: [ 
							                                       aTuple copy
								                                       at: 4
								                                       put:
									                                       (shapeBySCC at:
											                                        aTuple
												                                        propertyToShape
												                                        propertyDfsSCC);
								                                       yourself ].
					                                (super
						                                 edgeForTuple: tup
						                                 lineBuilder: treeEdgeBuilder)
						                                pushFront;
						                                yourself ].

				              layoutEdges := super
					                             layoutTuples:
						                             (innerTreeTuples flatCollect: [ 
							                              :each | 
							                              each propertyFromShape
								                              propertyDfsSCC
							                              ==
							                              each propertyToShape
								                              propertyDfsSCC
								                              ifTrue: [ { each } ]
								                              ifFalse: [ #(  ) ] ])
					                             lineBuilder: layoutLineBuilder.

				              self layoutOn: aSCC edges: layoutEdges.

				              composite
					              adjustToChildren;
					              padding: Float goldenRatio double.

				              boxShape extent: composite extent.

				              self layoutOn: shapes edges: edges.

				              composite position: boxShape position.
				              RSLocation new center stick: composite on: boxShape.

				              (outgoingEdges select: [ :each | 
					               each from == boxShape ]) do: [ :each | 
					              boxShape canvas removeShape: each ].


				              boxShape canvas
					              add: composite;
					              signalUpdate;
					              zoomToFit ];
			              yourself: [ :aCircle | 
			              shapeBySCC at: aSCC put: aCircle ] ].

	^ super shapes: sccsShapes
]

{ #category : #'as yet unclassified' }
CTCollapsedSccDfsPainter >> treeTuples: aCollection lineBuilder: lineBuilder [

	treeTuples := aCollection.
	treeEdgeBuilder := lineBuilder.

	outgoingEdges := super
		                 treeTuples: (self liftTuples: treeTuples)
		                 lineBuilder: lineBuilder.

	^ outgoingEdges
		  do: [ :anEdge | associations add: anEdge from -> anEdge to ];
		  yourself
]

{ #category : #initialization }
CTCollapsedSccDfsPainter >> visit [

	associations := Set new.
	
	^ super visit
]
