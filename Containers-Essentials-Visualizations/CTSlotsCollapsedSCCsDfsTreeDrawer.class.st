Class {
	#name : #CTSlotsCollapsedSCCsDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsCollapsedSCCsDfsTreeDrawer >> addAll: shapes onCanvas: aCanvas [

	| sccsShapes |
	sccsShapes := stronglyConnectedComponents collect: [ :aSCC | 
		              | radius |
		              radius := (aSCC size / Float pi) sqrt
		                        * Float goldenRatio double.
		              RSBox new
			              model: aSCC;
			              "radius: radius;
			              "height: aSCC size;
			              width: (aSCC
					               inject: 1
					               into: [ :acc :each | 
						               acc + each propertyIsArticulationObject asInteger ]);
			              color: Color white;
			              withBorder;
			              addInteraction: RSDraggable new;
			              yourself: [ :aCircle | 
				              shapeBySCC at: aSCC put: aCircle ] ].

	^ super addAll: sccsShapes onCanvas: aCanvas
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [
"
	backTuples do: [ :aTuple | 
		| t |
		t := self fixEndShapeOfTuple: aTuple.
		aTuple propertyFromShape ~= aTuple propertyToShape ifTrue: [ 
			""Error signal:
				'Logical inconsistency: a backward edge is trying to exiting from its SCC.'"" ] ].

	^ super backTuples: backTuples lineBuilder: lineBuilder"
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> cpapControllerHorizontal [

	^ RSStartEndCPAPController new
		  controller: RSHorizontalCPAPController new;
		  startAttachPoint: RSHorizontalAttachPoint new;
		  endAttachPoint: RSHorizontalEndBorderAttachPoint new;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	"| tuples |
	tuples := crossTuples
		          collect: [ :aTuple | self fixEndShapeOfTuple: aTuple ]
		          thenSelect: [ :r | 
		          r propertyFromShape ~= r propertyToShape ].

	^ super crossTuples: tuples lineBuilder: lineBuilder"
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> fixEndShapeOfTuple: aTuple [

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

	"| tuples |
	tuples := forwardTuples
		          collect: [ :aTuple | self fixEndShapeOfTuple: aTuple ]
		          thenSelect: [ :r | 
		          r propertyFromShape ~= r propertyToShape ].

	 super forwardTuples: tuples lineBuilder: lineBuilder.
	self layoutTuples: forwardTuples lineBuilder: lineBuilder"
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := treeTuples
		          collect: [ :aTuple | self fixEndShapeOfTuple: aTuple ]
		          thenSelect: [ :r | 
		          r propertyFromShape ~= r propertyToShape ].

	^ super layoutTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsCollapsedSCCsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	| tuples edges shapes |
	tuples := treeTuples
		          collect: [ :aTuple | self fixEndShapeOfTuple: aTuple ]
		          thenSelect: [ :r | 
		          r propertyFromShape ~= r propertyToShape ].

	"edges := super layoutTuples: tuples lineBuilder: lineBuilder."

	"shapes := (tuples flatCollect: [ :t | { t propertyFromShape . t propertyToShape  } ]) asIdentitySet .
		
	self layoutOn: shapes edges: edges "
]
