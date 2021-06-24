Class {
	#name : #CTSlotsSCCsDfsTreeDrawer,
	#superclass : #CTSCCsDfsTreeDrawer,
	#instVars : [
		'edgessOfSCCs'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsSCCsDfsTreeDrawer >> addAll: aCollection onCanvas: aCanvas [

	| scale max lowerBound sccsShapes |
	lowerBound := 1.
	max := stronglyConnectedComponents
		       inject: lowerBound
		       into: [ :m :each | m max: each size ].
	scale := NSScale ln
		         domain: (Array with: lowerBound with: max);
		         range: (Array with: Color lightRed with: Color red);
		         yourself.

	sccsShapes := stronglyConnectedComponents collect: [ :aSCC | 
		              RSComposite new
			              model: aSCC;
			              shapes: aSCC;
			              padding: Float goldenRatio double;
			              borderDo: [ :aBorder | 
				              aBorder
					              joinRound;
					              color: (scale scale: aSCC size) translucent ];
			              addInteraction: RSDraggable new;
			              yourself: [ :aComposite | 
				              shapeBySCC at: aSCC put: aComposite.

				              aSCC do: [ :each | 
					              each removeInteractionIfPresent: RSDraggable ] ] ].

	^ super addAll: sccsShapes onCanvas: aCanvas
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [

	backTuples do: [ :aTuple | 
		self fixEndShapeOfTuple: aTuple ifNecessary: [ :toShape | 
			Error signal:
				'Logical inconsistency: a backward edge is trying to exiting from its SCC.' ] ].

	^ super backTuples: backTuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := crossTuples collect: [ :aTuple | 
		          self
			          fixEndShapeOfTuple: aTuple
			          ifNecessary: [ :toShape | 
				          aTuple copy
					          at: 4 put: toShape;
					          yourself ] ].

	^ super crossTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> edgeForTuple: aTuple lineBuilder: lineBuilder [

	| edge |
	edge := super edgeForTuple: aTuple lineBuilder: lineBuilder.

	aTuple propertyFromShape propertyDfsSCC
	== aTuple propertyToShape propertyDfsSCC ifFalse: [ 
		edge
			color: edge color translucent;
			width: 0.5 ].

	^ edge
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> fixEndShapeOfTuple: aTuple ifNecessary: aBlock [

	| boxShape boxParentShape toSCCShape fromSCCShape |
	boxShape := aTuple propertyFromSlotShape.
	boxParentShape := aTuple propertyFromShape.

	toSCCShape := shapeBySCC at: aTuple propertyToShape propertyDfsSCC.
	fromSCCShape := shapeBySCC at:
		                aTuple propertyFromShape propertyDfsSCC.

	^ fromSCCShape == toSCCShape
		  ifTrue: [ aTuple ]
		  ifFalse: [ aBlock value: toSCCShape ]
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> forwardTuples: forwardTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := forwardTuples collect: [ :aTuple | 
		          self
			          fixEndShapeOfTuple: aTuple
			          ifNecessary: [ :toShape | 
				          aTuple copy
					          at: 4 put: toShape;
					          yourself ] ].

	^ super forwardTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> layoutOn: sccShapes edges: aCollectionOfLines [

	stronglyConnectedComponents do: [ :each | 
		| sccShape |
		sccShape := shapeBySCC at: each.
		super layoutOn: sccShape shapes edges: (edgessOfSCCs at: each).
		sccShape
			adjustToChildren;
			padding: 2 ].

	^ super layoutOn: sccShapes edges: aCollectionOfLines
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	| tuples tuplesOfSCCs |
	tuplesOfSCCs := IdentityDictionary new.

	tuples := treeTuples flatCollect: [ :aTuple | 
		          | boxShape boxParentShape toSCCShape fromSCCShape |
		          boxShape := aTuple propertyFromSlotShape.
		          boxParentShape := aTuple propertyFromShape.
		          toSCCShape := shapeBySCC at:
			                        aTuple propertyToShape propertyDfsSCC.
		          fromSCCShape := shapeBySCC at:
			                          aTuple propertyFromShape propertyDfsSCC.

		          fromSCCShape == toSCCShape
			          ifTrue: [ 
				          | innerTuples |
				          self assert: fromSCCShape model == toSCCShape model.
				          innerTuples := tuplesOfSCCs
					                         at: toSCCShape model
					                         ifAbsentPut: [ OrderedCollection new ].
				          innerTuples add: aTuple.
				          Array empty ]
			          ifFalse: [ 
				          { (aTuple copy
					           at: 3 put: fromSCCShape;
					           at: 4 put: toSCCShape;
					           yourself) } ] ].

	edgessOfSCCs := stronglyConnectedComponents
		                inject: IdentityDictionary new
		                into: [ :aDictionary :each | 
			                | edges sccTuples |
			                sccTuples := tuplesOfSCCs
				                             at: each
				                             ifAbsent: [ OrderedCollection new ].
			                edges := super
				                         layoutTuples: sccTuples
				                         lineBuilder: lineBuilder.
			                aDictionary
				                at: each put: edges;
				                yourself ].

	^ super layoutTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := treeTuples collect: [ :aTuple | 
		          self
			          fixEndShapeOfTuple: aTuple
			          ifNecessary: [ :toShape | 
				          aTuple copy
					          at: 4 put: toShape;
					          yourself ] ].

	^ super treeTuples: tuples lineBuilder: lineBuilder
]
