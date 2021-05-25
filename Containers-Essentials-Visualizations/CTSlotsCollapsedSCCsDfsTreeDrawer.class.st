Class {
	#name : #CTSlotsCollapsedSCCsDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsCollapsedSCCsDfsTreeDrawer >> addAll: shapes onCanvas: aCanvas [

	| sccsShapes |
	sccsShapes := stronglyConnectedComponents collect: [ :aSCC | 
		              RSBox new
			              model: (aSCC collect: [ :aShape | aShape model ]);
			              size: aSCC size sqrt * Float goldenRatio double;
			              color: Color white;
			              addInteraction:
				              (RSPopup new text: [ :aModel | aModel size ]);
			              withBorder;
			              cornerRadius: Float goldenRatio double;
			              addInteraction: RSDraggable new;
			              yourself: [ :aCircle | 
				              shapeBySCC at: aSCC put: aCircle ] ].

	^ super addAll: sccsShapes onCanvas: aCanvas
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := self liftTuples: backTuples.

	self assert: tuples isEmpty.

	^ super backTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> cpapControllerBezierDirected [

	^ RSStartEndCPAPController new
		  controller: RSDirectedBezierCPAPController new;
		  startAttachPoint: RSHorizontalAttachPoint new;
		  endAttachPoint: RSBorderAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> cpapControllerHorizontal [

	^ RSStartEndCPAPController new
		  controller: RSHorizontalCPAPController new;
		  startAttachPoint: RSHorizontalAttachPoint new;
		  endAttachPoint: RSHorizontalAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	^ super
		  crossTuples: (self liftTuples: crossTuples)
		  lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	^ lineBuilder
		  edgeFrom: aTuple propertyFromShape
		  to: aTuple propertyToShape
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> fixFromToShapesOfTuple: aTuple [

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
CTSlotsCollapsedSCCsDfsTreeDrawer >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	^ super
		  forwardTuples: (self liftTuples: forwardTuples)
		  lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ super
		  layoutTuples: (self liftTuples: treeTuples)
		  lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> liftTuples: tuples [

	^ tuples
		  collect: [ :aTuple | self fixFromToShapesOfTuple: aTuple ]
		  thenReject: [ :r | r propertyFromShape == r propertyToShape ]
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	^ super
		  treeTuples: (self liftTuples: treeTuples)
		  lineBuilder: lineBuilder
]
