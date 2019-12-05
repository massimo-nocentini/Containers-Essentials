Extension { #name : #Association }

{ #category : #'*Collections-Unordered-Graph' }
Association >> asEdge [
	^ Edge new
]

{ #category : #'*Collections-Unordered-Graph' }
Association >> weight: aWeight [
	^ WeightedAssociation new
		key: self key value: self value;
		weight: aWeight;
		yourself
]
