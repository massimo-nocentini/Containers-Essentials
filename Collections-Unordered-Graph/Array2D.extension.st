Extension { #name : #Array2D }

{ #category : #'*Collections-Unordered-Graph' }
Array2D >> asGraph [
	^ Graph fromArray2D: self
]
