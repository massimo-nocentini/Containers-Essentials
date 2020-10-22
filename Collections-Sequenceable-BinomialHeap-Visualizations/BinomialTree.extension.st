Extension { #name : #BinomialTree }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> asRecursiveSlotsInGroup: aGroup knownReferencesSet: aSet [
	| binomialTrees shapes edges eb fromShapes |
	binomialTrees := self nodes.
	shapes := binomialTrees
		          collect: [ :aBinomialTree | 
			          | g |
			          g := aBinomialTree asSlotsGroupKnownReferences:
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
					               anArray recursiveReferences collect: [ :aValueLink | 
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

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> asSlotsGroupKnownReferences: anIdentitySet [
	| aGroup firstAndLastLinks linksComposite linksGroup eb meShape |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           children ifNotNil: aStream |<| #nextPut: ]).
	linksGroup := children ifNil: [ RSGroup new ] ifNotNil: [ :r | 
		              r
			              asSlotsGroupRecursiveKnownReferences: anIdentitySet
			              layoutBlock: [ :shapes | 
			              RSVerticalLineLayout on: shapes ] ].
	linksComposite := linksGroup asShape.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes:
			      ({ (linksGroup shapeFromModel: children) } reject: #isNil);
		      yourself.
	firstAndLastLinks := eb
		                     fromShapes:
			                     { (aGroup shapeFromModel: children) };
		                     useAssociations:
			                     { children asReflexiveAssociation }.
	meShape := aGroup asShapeFor: self.
	RSVerticalLineLayout new
		alignCenter;
		applyOn: { 
				meShape.
				linksComposite }.
	^ (RSGroup new
		   add: meShape;
		   add: linksComposite;
		   addAll: firstAndLastLinks;
		   yourself) @ RSDraggable
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges [
	^ self edges: content -> content ~~> nil
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges: incomingEdges [
	^ children asLinkedList
		foldr: [ :each :acc | each edges: content -> each content ~~> acc ]
		init: incomingEdges
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> gtInspectorRecursiveSlotsInCanvas: aCanvas knownReferencesSet: aSet [
	| aGroup |
	aGroup := RSGroup new.
	self asRecursiveSlotsInGroup: aGroup knownReferencesSet: aSet.
	aGroup @ RSDraggable.
	^ aCanvas
		  addAll: aGroup;
		  yourself
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
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

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> gtInspectorTreeViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ self gtInspectorTreeViewUsingCanvas: RSCanvas new ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> gtInspectorTreeViewUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  RSLabel new
				  text: aVertex content;
				  color: Color black;
				  yourself ]
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> instVarsNamesOrderedCollection [
	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ { 
		  #children asReflexiveAssociation.
		  #content asReflexiveAssociation }
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> nodes [
	| subtreeChildren |
	subtreeChildren := children asLinkedList flatCollect: [ 
		                   :aBinomialTree | aBinomialTree nodes ].
	^ Array with: self withAll: subtreeChildren
]
