Extension { #name : #SBRALBinaryTreeLeaf }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeLeaf >> edges [
	^ self
		edges:
			(ValueLink new
				value: content -> content;
				nextLink: nil;
				yourself)
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRALBinaryTreeLeaf >> edges: outerEdges [
	^ outerEdges
]
