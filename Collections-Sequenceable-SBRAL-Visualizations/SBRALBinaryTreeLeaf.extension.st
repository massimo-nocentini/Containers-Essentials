Extension { #name : #SBRALBinaryTreeLeaf }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeLeaf >> edges [
	^ self edges: content -> content ~~> nil
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeLeaf >> edges: outerEdges [
	^ outerEdges
]
