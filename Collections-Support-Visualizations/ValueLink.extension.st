Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> asValueLinksGroup [
	| links shapes edges eb |
	links := self valueLinks.
	shapes := links collect: [ :aValueLink | 
		          | g |
		          g := aValueLink asSlotsShapeKnownReferences: links.
		          (g asShapeFor: aValueLink) @ RSDraggable ].
	eb := (RSEdgeBuilder new: RSArrowedLine new)
		      color: Color gray;
		      toShapes: shapes;
		      yourself.
	edges := eb
		         fromShapes: (links
				          with: shapes
				          collect: [ :link :shape | 
					          shape shapeFromModel: link nextLink ]);
		         useAssociations:
			         (links collect: [ :r | r asReflexiveAssociation ]).
	RSVerticalLineLayout on: shapes.
	^ RSGroup new
		  addAll: shapes;
		  addAll: edges;
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges [
	^ self edges: nil parent: self
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges: incomingEdges parent: parent [
	| edges |
	edges := parent -> self ~~> incomingEdges.
	^ nextLink
		  ifNil: [ self -> nil ~~> edges ]
		  ifNotNil: [ :nl | nl edges: edges parent: self ]
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Links';
		  initializeCanvas: [ 
			  self gtInspectorLinksUsingCanvas: RSCanvas new ];
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> gtInspectorLinksUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  RSLabel new
				  text: aVertex content value;
				  color: Color black;
				  yourself ]
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> gtInspectorValueLinksChainGraphIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Links chain';
		  initializeCanvas: [ 
			  (RSCanvas new
				   addAll: self asValueLinksGroup;
				   yourself) @ RSCanvasController ];
		  yourself
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> instVarsNamesOrderedCollection [
	^ #( value nextLink )
]
