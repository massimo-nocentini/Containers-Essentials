Extension { #name : #ValueLink }

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges [
	^ self edges: nil parent: self
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> edges: aLink parent: parent [
	| edges edge |
	edge := parent -> self.
	edges := edge ~~> aLink.
	^ nextLink
		  ifNil: [ edges ]
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
			  | anObject |
			  anObject := aVertex content
				              ifNil: [ self halt ]
				              ifNotNil: [ :content | content value ].
			  RSLabel new
				  text:
					  (String streamContents: [ :aStream | anObject printOn: aStream ]);
				  color: Color black;
				  yourself ]
]

{ #category : #'*Collections-Support-Visualizations' }
ValueLink >> instVarsNamesOrderedCollection [
	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ { 
		  #nextLink asReflexiveAssociation.
		  #value asReflexiveAssociation }
]
