Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Unordered-Graph' }
SequenceableCollection >> asGraph [
	| vertices edges |
	vertices := Dictionary new.
	edges := self
		collect: [ :anAssociation | 
			| from to |
			from := vertices
				at: anAssociation key
				ifAbsentPut: [ anAssociation key asVertex ].
			to := vertices
				at: anAssociation value
				ifAbsentPut: [ anAssociation value asVertex ].
			anAssociation asEdge
				from: from;
				to: to;
				yourself ].
	^ Graph new
		vertices: vertices;
		edges: edges;
		yourself
]
