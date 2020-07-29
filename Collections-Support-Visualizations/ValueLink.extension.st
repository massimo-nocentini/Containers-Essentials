Extension { #name : #ValueLink }

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
