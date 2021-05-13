Class {
	#name : #CTSlotsSCCsDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#instVars : [
		'edgessOfSCCs'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsSCCsDfsTreeDrawer >> addAll: shapes onCanvas: aCanvas [

	shapeBySCC := IdentityDictionary new.

	sccsShapes := stronglyConnectedComponents collect: [ :aSCC | 
		              RSComposite new
			              model: aSCC;
			              shapes: aSCC;
			              padding: 2;
			              borderDo: [ :aBorder | 
				              aSCC size > 1
					              ifTrue: [ 
						              aBorder
							              width: 1;
							              dashArray: #( 4 );
							              joinRound ]
					              ifFalse: [ aBorder width: 0 ] ];
			              addInteraction: RSDraggable new;
			              yourself: [ :aComposite | 
				              shapeBySCC at: aSCC put: aComposite.

				              aSCC do: [ :each | 
					              each removeInteractionIfPresent: RSDraggable ] ] ].

	^ super addAll: sccsShapes onCanvas: aCanvas
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> backTuples: backTuples lineBuilder: lineBuilder [
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> crossTuples: crossTuples lineBuilder: lineBuilder [

	
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> forwardTuples: forwardTuples lineBuilder: lineBuilder [
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> layoutOn: sccShapes edges: edges [

	stronglyConnectedComponents do: [ :each | 
		| sccShape |
		sccShape := shapeBySCC at: each.
		super layoutOn: sccShape shapes edges: (edgessOfSCCs at: each).
		sccShape
			adjustToChildren;
			padding: 2 ].

	^ super layoutOn: sccShapes edges: edges
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	| tuples tuplesOfSCCs |
	edgessOfSCCs := IdentityDictionary new.
	tuplesOfSCCs := IdentityDictionary new.

	tuples := treeTuples flatCollect: [ :aTuple | 
		          | boxShape boxParentShape toShape toSCCShape fromSCCShape |
		          boxShape := aTuple propertyFromSlotShape.
		          boxParentShape := aTuple propertyFromShape.
		          toShape := toShapes at: boxShape model.
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

	stronglyConnectedComponents do: [ :each | 
		| edges |
		edges := super
			         layoutTuples:
			         (tuplesOfSCCs at: each ifAbsent: [ OrderedCollection new ])
			         lineBuilder: lineBuilder.
		edgessOfSCCs at: each put: edges ].

	^ super layoutTuples: tuples lineBuilder: lineBuilder
]

{ #category : #'as yet unclassified' }
CTSlotsSCCsDfsTreeDrawer >> treeTuples: treeTuples lineBuilder: lineBuilder [

	| tuples |
	tuples := treeTuples collect: [ :aTuple | 
		          | boxShape boxParentShape toShape toSCCShape fromSCCShape |
		          boxShape := aTuple propertyFromSlotShape.
		          boxParentShape := aTuple propertyFromShape.
		          toShape := toShapes at: boxShape model.
		          toSCCShape := shapeBySCC at:
			                        aTuple propertyToShape propertyDfsSCC.
		          fromSCCShape := shapeBySCC at:
			                          aTuple propertyFromShape propertyDfsSCC.

		          fromSCCShape == toSCCShape ifFalse: [ 
			          toShape := toSCCShape ].

		          aTuple copy
			          at: 4 put: toShape;
			          yourself ].

	^ super treeTuples: tuples lineBuilder: lineBuilder
]
