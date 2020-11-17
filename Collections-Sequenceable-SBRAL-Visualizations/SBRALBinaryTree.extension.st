Extension { #name : #SBRALBinaryTree }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTree >> edges [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTree >> edges: outerEdges [
	self subclassResponsibility
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTree >> gtInspectorTreeViewUsingCanvas: aCanvas [
	^ self edges asLinkedList asTree
		  gtInspectorGraphViewIn: aCanvas
		  vertexBlock: [ :aVertex | 
			  RSLabel new
				  text: aVertex content;
				  color: Color black;
				  yourself ]
]
