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
SBRALBinaryTree >> gtInspectorTreeUsingMondrianBuilder: aMondrian [
	self edges asLinkedList asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: #content;
				color: Color black ]
		edge: [ :shape | shape orthoVerticalLine ]
		layout: #tree
]
