Class {
	#name : #RedNode,
	#superclass : #AbstractRBNode,
	#category : #'Collections-Sequenceable-BalancedSet'
}

{ #category : #converting }
RedNode >> asBlackNode [
	^ BlackNode new
		  value: value;
		  yourself
]

{ #category : #'as yet unclassified' }
RedNode >> balance: aBlock representation: aDoubleLink [
	^ aDoubleLink
]

{ #category : #enumerating }
RedNode >> balanceLeftTreeOf: L leftTreeOf: aDoubleLink continuation: skip [
	^ L previousLink ifNil: skip ifNotNil: [ :LL | 
		  LL value
			  balanceTree: LL
			  leftTreeOf: L
			  leftTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #enumerating }
RedNode >> balanceLeftTreeOf: R rightTreeOf: aDoubleLink continuation: skip [
	^ R previousLink ifNil: skip ifNotNil: [ :RL | 
		  RL value
			  balanceTree: RL
			  leftTreeOf: R
			  rightTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #enumerating }
RedNode >> balanceRightTreeOf: L leftTreeOf: aDoubleLink continuation: skip [
	^ L nextLink ifNil: skip ifNotNil: [ :LR | 
		  LR value
			  balanceTree: LR
			  rightTreeOf: L
			  leftTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #enumerating }
RedNode >> balanceRightTreeOf: R rightTreeOf: aDoubleLink continuation: skip [
	^ R nextLink ifNil: skip ifNotNil: [ :RR | 
		  RR value
			  balanceTree: RR
			  rightTreeOf: R
			  rightTreeOf: aDoubleLink
			  continuation: skip ]
]

{ #category : #enumerating }
RedNode >> balanceTree: LL leftTreeOf: L leftTreeOf: aDoubleLink continuation: skip [
	self assert: value == LL value value.
	^ { 
		  LL previousLink.
		  value.
		  LL nextLink.
		  L value value.
		  L nextLink.
		  aDoubleLink value value.
		  aDoubleLink nextLink }
]

{ #category : #enumerating }
RedNode >> balanceTree: RL leftTreeOf: R rightTreeOf: aDoubleLink continuation: skip [
	self assert: value == RL value value.
	^ { 
		  aDoubleLink previousLink.
		  aDoubleLink value value.
		  RL previousLink.
		  value.
		  RL nextLink.
		  R value value.
		  R nextLink }
]

{ #category : #enumerating }
RedNode >> balanceTree: LR rightTreeOf: L leftTreeOf: aDoubleLink continuation: skip [
	self assert: value == LR value value.
	^ { 
		  L previousLink.
		  L value value.
		  LR previousLink.
		  value.
		  LR nextLink.
		  aDoubleLink value value.
		  aDoubleLink nextLink }
]

{ #category : #enumerating }
RedNode >> balanceTree: RR rightTreeOf: R rightTreeOf: aDoubleLink continuation: skip [
	self assert: value == RR value value.
	^ { 
		  aDoubleLink previousLink.
		  aDoubleLink value value.
		  R previousLink.
		  R value value.
		  RR previousLink.
		  value.
		  RR nextLink }
]
