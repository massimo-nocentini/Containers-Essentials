Class {
	#name : #BinomialTree,
	#superclass : #Object,
	#instVars : [
		'content',
		'children'
	],
	#category : #'Collections-Sequenceable-BinomialHeap'
}

{ #category : #creating }
BinomialTree class >> leaf: anObject [
	^ self node: anObject children: nil
]

{ #category : #creating }
BinomialTree class >> node: anObject children: children [
	^ self new
		content: anObject;
		children: children;
		yourself
]

{ #category : #converting }
BinomialTree >> asRecursiveSlotsInGroup: aGroup knownReferencesSet: aSet [
	| binomialTrees shapes edges eb fromShapes |
	binomialTrees := self nodes.
	shapes := binomialTrees
		          collect: [ :aBinomialTree | 
			          | g |
			          g := aBinomialTree asSlotsShapeKnownReferences:
				               aSet | binomialTrees.
			          g asShape "For: aBinomialTree" ]
		          as: Array.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: shapes;
		      yourself.
	fromShapes := (binomialTrees asArray
		               with: shapes
		               collect: [ :aBinomialTree :shape | 
			               aBinomialTree children
				               ifNil: [ Array empty ]
				               ifNotNil: [ :anArray | 
					               anArray valueLinks collect: [ :aValueLink | 
						               (shape shapeFromModel: aValueLink) 
							               shapeFromModel: aValueLink value ] ] ]) 
		              flatCollect: #yourself.
	edges := eb
		         fromShapes: fromShapes;
		         useAssociations:
			         (binomialTrees collect: [ :r | r asReflexiveAssociation ]).
	binomialTrees asArray
		with: shapes
		do: [ :aBinomialTree :shape | shape model: aBinomialTree ].
	eb shapes: shapes.
	RSHorizontalTreeLayout
		on: shapes
		edges: (eb connectToAll: [ :aBinomialTree | 
				 aBinomialTree children asLinkedList ]).
	binomialTrees asArray
		with: shapes
		do: [ :aBinomialTree :shape | shape model: nil ].
	^ aGroup
		  addAll: shapes;
		  addAll: edges;
		  yourself
]

{ #category : #accessing }
BinomialTree >> children [
	^ children
]

{ #category : #accessing }
BinomialTree >> children: anObject [
	children := anObject
]

{ #category : #accessing }
BinomialTree >> content [
	^ content
]

{ #category : #accessing }
BinomialTree >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
BinomialTree >> gtInspectorRecursiveSlotsInCanvas: aCanvas knownReferencesSet: aSet [
	| aGroup |
	aGroup := RSGroup new.
	self asRecursiveSlotsInGroup: aGroup knownReferencesSet: aSet.
	aGroup @ RSDraggable.
	^ aCanvas
		  addAll: aGroup;
		  yourself
]

{ #category : #'as yet unclassified' }
BinomialTree >> gtInspectorRecursiveSlotsViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Recursive slots';
		  initializeCanvas: [ 
			  | aCanvas |
			  aCanvas := self
				             gtInspectorRecursiveSlotsInCanvas: RSCanvas new
				             knownReferencesSet: IdentitySet empty.
			  aCanvas @ RSCanvasController ];
		  yourself
]

{ #category : #'as yet unclassified' }
BinomialTree >> linkBinomialTree: aTree [
	| x |
	x := aTree content.
	^ content < x
		ifTrue: [ self class node: content children: aTree ~~> children ]
		ifFalse: [ self class node: x children: self ~~> aTree children ]
]

{ #category : #converting }
BinomialTree >> nodes [
	| subtreeChildren |
	subtreeChildren := children asLinkedList flatCollect: [ 
		                   :aBinomialTree | aBinomialTree nodes ].
	^ Array with: self withAll: subtreeChildren
]
