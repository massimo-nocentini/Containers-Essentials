Extension { #name : #LinkedList }

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> , other [
	"Optimized version of append for this specific linked container"

	^ other
		ifEmpty: [ self ]
		ifNotEmpty: [ self
				addLast: other firstLink;
				yourself ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> allButFirst [
	^ self cdr
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> car [
	"Return the very first element"

	^ self first
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> cdr [
	"Returns the tail of this list"

	^ self
		ifNotEmpty: [ firstLink nextLink
				ifNil: [ self class new ]
				ifNotNil: [ :nl | self class with: nl ] ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> firstLinkControlPointsController [

	^ RSBlockCPController new
		  block: [ :edge | 
			  | f t ap top offset |
			  ap := edge attachPoint.
			  f := ap startingPointOf: edge.
			  t := ap endingPointOf: edge.

			  offset := 5.
			  top := t y - (edge to height / 2) - offset.
			  Array
				  with: f
				  with: f x @ top
				  with: t x @ top
				  with: t ];
		  yourself
]

{ #category : #'*Collections-Sequenceable-Extensions' }
LinkedList >> lastLinkControlPointsController [

	^ RSBlockCPController new
		  block: [ :edge | 
			  | f t ap bottom offset |
			  ap := edge attachPoint.
			  f := ap startingPointOf: edge.
			  t := ap endingPointOf: edge.

			  offset := 5.
			  bottom := t y + (edge to height / 2) + offset.
			  Array
				  with: f
				  with: f x @ bottom
				  with: t x @ bottom
				  with: t ];
		  yourself
]
