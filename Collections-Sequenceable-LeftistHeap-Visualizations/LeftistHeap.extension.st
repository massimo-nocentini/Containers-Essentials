Extension { #name : #LeftistHeap }

{ #category : #'*Collections-Sequenceable-LeftistHeap-Visualizations' }
LeftistHeap >> gtInspectorTreeUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  | text content |
			  content := aVertex content.
			  text := String streamContents: [ :s | 
				          content value
					          ifNil: [ s nextPut: $• ]
					          ifNotNil: [ :v | v printOn: s ].
				          s
					          nextPut: $₍;
					          nextPutAll: content rank asString subscript;
					          nextPut: $₎ ].
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
