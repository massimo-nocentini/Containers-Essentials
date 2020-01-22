Extension { #name : #SBRALBinaryTreeNode }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeNode >> edges [
	^ self edges: nil
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeNode >> edges: outerEdges [
	^ left
		edges:
			(right
				edges:
					content -> left content ~~> (content -> right content ~~> outerEdges))
]
