"
| L |
			  L := aDoubleLink previousLink.
			  L value ifNil: skip ifNotNil: [ :l | 
				  l isRedNode
					  ifTrue: [ 
						  | LL |
						  LL := L previousLink.
						  LL value ifNil: skip ifNotNil: [ :ll | 
							  ll isRedNode
								  ifTrue: [ 
									  aBlock valueWithArguments: { 
											  LL previousLink.
											  LL value value.
											  LL nextLink.
											  L value value.
											  L nextLink.
											  aDoubleLink value value.
											  aDoubleLink nextLink } ]
								  ifFalse: skip ] ]
					  ifFalse: [ 
						  | LR |
						  LR := L nextLink.
						  LR value ifNil: skip ifNotNil: [ :lr | 
							  lr isRedNode
								  ifTrue: [ 
									  aBlock valueWithArguments: { 
											  L previousLink.
											  L value value.
											  LR nextLink.
											  LR value value.
											  LR nextLink.
											  aDoubleLink value value.
											  aDoubleLink nextLink } ]
								  ifFalse: skip ] ] ] 

or: [ :skip | 
			  | R |
			  R := aDoubleLink nextLink.
			  R value ifNil: skip ifNotNil: [ :r | 
				  r isRedNode
					  ifTrue: [ 
						  | RL |
						  RL := R previousLink.
						  RL value ifNil: skip ifNotNil: [ :rl | 
							  rl isRedNode
								  ifTrue: [ 
									  aBlock valueWithArguments: { 
											  aDoubleLink previousLink.
											  aDoubleLink value value.
											  RL previousLink.
											  RL value value.
											  RL nextLink.
											  R value value.
											  R nextLink } ]
								  ifFalse: skip ] ]
					  ifFalse: [ 
						  | RR |
						  RR := R nextLink.
						  RR value ifNil: skip ifNotNil: [ :rr | 
							  rr isRedNode
								  ifTrue: [ 
									  aBlock valueWithArguments: { 
											  aDoubleLink previousLink.
											  aDoubleLink value value.
											  R previousLink.
											  R value value.
											  RR previousLink.
											  RR value value.
											  RR nextLink } ]
								  ifFalse: skip ] ] ] ]
"
Class {
	#name : #BlackNode,
	#superclass : #AbstractRBNode,
	#category : #'Collections-Sequenceable-BalancedSet'
}

{ #category : #converting }
BlackNode >> asBlackNode [
	^ self
]

{ #category : #'as yet unclassified' }
BlackNode >> balance: aBlock representation: aDoubleLink [
	| args |
	args := Continuation
		        tries: { 
				        [ :skip | 
				        self balanceLeftLeftTreeOf: aDoubleLink continuation: skip ].
				        [ :skip | 
				        self
					        balanceLeftRightTreeOf: aDoubleLink
					        continuation: skip ].
				        [ :skip | 
				        self
					        balanceRightLeftTreeOf: aDoubleLink
					        continuation: skip ].
				        [ :skip | 
				        self
					        balanceRightRightTreeOf: aDoubleLink
					        continuation: skip ] }
		        otherwise: [ nil ].
	^ args
		  ifNil: [ aDoubleLink ]
		  ifNotNil: [ aBlock valueWithArguments: args ]
]

{ #category : #dispatching }
BlackNode >> balanceLeftLeftTreeOf: aDoubleLink continuation: skip [
	^ aDoubleLink previousLink ifNil: skip ifNotNil: [ :L | 
		  L value
			  balanceLeftTreeOf: L
			  leftTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #dispatching }
BlackNode >> balanceLeftRightTreeOf: aDoubleLink continuation: skip [
	^ aDoubleLink previousLink ifNil: skip ifNotNil: [ :L | 
		  L value
			  balanceRightTreeOf: L
			  leftTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #dispatched }
BlackNode >> balanceLeftTreeOf: aDoubleLink leftTreeOf: aDoubleLink2 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceLeftTreeOf: aDoubleLink rightTreeOf: aDoubleLink2 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatching }
BlackNode >> balanceRightLeftTreeOf: aDoubleLink continuation: skip [
	^ aDoubleLink nextLink ifNil: skip ifNotNil: [ :R | 
		  R value
			  balanceLeftTreeOf: R
			  rightTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #dispatching }
BlackNode >> balanceRightRightTreeOf: aDoubleLink continuation: skip [
	^ aDoubleLink nextLink ifNil: skip ifNotNil: [ :R | 
		  R value
			  balanceRightTreeOf: R
			  rightTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #dispatched }
BlackNode >> balanceRightTreeOf: aDoubleLink leftTreeOf: aDoubleLink2 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceRightTreeOf: aDoubleLink rightTreeOf: aDoubleLink2 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceTree: aDoubleLink leftTreeOf: aDoubleLink2 leftTreeOf: aDoubleLink3 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceTree: aDoubleLink leftTreeOf: aDoubleLink2 rightTreeOf: aDoubleLink3 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceTree: aDoubleLink rightTreeOf: aDoubleLink2 leftTreeOf: aDoubleLink3 continuation: aContinuation [
	^ aContinuation value
]

{ #category : #dispatched }
BlackNode >> balanceTree: aDoubleLink rightTreeOf: aDoubleLink2 rightTreeOf: aDoubleLink3 continuation: aContinuation [
	^ aContinuation value
]
