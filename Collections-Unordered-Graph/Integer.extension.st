Extension { #name : #Integer }

{ #category : #'*Collections-Unordered-Graph' }
Integer >> asGraphWithRecurrence: aBlock [
	^ (((0 to: self - 1)
		flatCollect: [ :row | (0 to: row) collect: [ :col | row @ col ] ])
		flatCollect: [ :aPoint | 
			| deps |
			deps := aBlock value: aPoint.
			deps collect: [ :each | aPoint -> each ] ]) asGraph
]
