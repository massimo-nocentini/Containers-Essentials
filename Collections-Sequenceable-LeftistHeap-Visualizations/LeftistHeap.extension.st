Extension { #name : #LeftistHeap }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreeUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  | text |
			  text := aVertex content printStringWithSubscriptRank.
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
LeftistHeap >> instVarsNamesOrderedCollection [
	^ { 
		  #previousLink asReflexiveAssociation.
		  #value asReflexiveAssociation.
		  #rank asReflexiveAssociation.
		  #nextLink asReflexiveAssociation }
]

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> printStringWithSubscriptRank [
	^ String streamContents: [ :s | 
		  value ifNil: [ s nextPut: $• ] ifNotNil: [ value printOn: s ].
		  s
			  nextPut: $₍;
			  nextPutAll: rank asString subscript;
			  nextPut: $₎ ]
]
