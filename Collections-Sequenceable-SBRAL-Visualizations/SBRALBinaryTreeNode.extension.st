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
					(ValueLink new
						value: content -> left content;
						nextLink:
							(ValueLink new
								value: content -> right content;
								nextLink: outerEdges;
								yourself);
						yourself))
]
