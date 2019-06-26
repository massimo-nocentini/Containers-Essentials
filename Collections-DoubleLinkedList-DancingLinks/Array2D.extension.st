Extension { #name : #Array2D }

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
Array2D class >> rows: r columns: c element: v at: aCollectionOfPoints [
	| matrix |
	matrix := self rows: r columns: c element: 0.
	aCollectionOfPoints
		do: [ :aPoint | matrix at: aPoint x at: aPoint y put: v ].
	^ matrix
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
Array2D class >> rows: r columns: c onesAt: aCollectionOfPoints [
	
	^ self rows: r columns: c element: 1 at: aCollectionOfPoints
]
