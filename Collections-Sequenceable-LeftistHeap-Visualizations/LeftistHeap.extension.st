Extension { #name : #LeftistHeap }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> asNodesGroup [
	| links shapes edges eb fromShapes |
	links := (self nodes: nil) asLinkedList as: IdentitySet.
	shapes := links
		          collect: [ :aValueLink | 
			          | g |
			          g := aValueLink asSlotsShapeKnownReferences: links.
			          g asShapeFor: aValueLink ]
		          as: Array.
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: shapes;
		      yourself.
	fromShapes := (links asArray with: shapes collect: [ :link :shape | 
		               { 
			               (shape shapeFromModel: link previousLink).
			               (shape shapeFromModel: link nextLink) } ]) 
		              flatCollect: #yourself.
	edges := eb
		         fromShapes: fromShapes;
		         useAssociations:
			         (links collect: [ :r | r asReflexiveAssociation ]).
	eb shapes: shapes.
	RSTreeLayout
		on: shapes
		edges: (eb connectTo: #previousLink) , (eb connectTo: #nextLink).
	^ (RSGroup new
		   addAll: shapes;
		   addAll: edges;
		   yourself) @ RSDraggable
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> edges [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> edges: outerEdges parentHeapNode: aValue [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreeUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  | text |
			  text := aVertex content
				          ifNil: [ String empty ]
				          ifNotNil: #printStringWithSubscriptRank.
			  RSLabel new
				  text: text;
				  color: Color black;
				  yourself ]
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Tree';
		  initializeCanvas: [ self gtInspectorTreeUsingCanvas: RSCanvas new ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorValueLinksChainGraphIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Nodes';
		  initializeCanvas: [ 
			  (RSCanvas new
				   addAll: self asNodesGroup;
				   yourself) @ RSCanvasController ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> instVarsNamesOrderedCollection [
	^ #( previousLink value nextLink )
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> printStringWithSubscriptRank [
	self subclassResponsibility
]
