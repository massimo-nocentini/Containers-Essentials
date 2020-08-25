Class {
	#name : #RedBlackTree,
	#superclass : #UnbalancedSet,
	#category : #'Collections-Sequenceable-BalancedSet'
}

{ #category : #adding }
RedBlackTree >> inDoubleLinkRepresentation: aDoubleLink push: anObject witness: aWitness continuation: aContinuation [
	| repr |
	repr := super
		        inDoubleLinkRepresentation: aDoubleLink
		        push: anObject
		        witness: aWitness
		        continuation: aContinuation.
	^ repr value
		  balance: [ :A :x :B :y :C :z :D | 
			  | L R |
			  L := DoubleLink new
				       previousLink: A;
				       value: (self node: x color: BlackNode);
				       nextLink: B;
				       yourself.
			  R := DoubleLink new
				       previousLink: C;
				       value: (self node: z color: BlackNode);
				       nextLink: D;
				       yourself.
			  DoubleLink new
				  previousLink: L;
				  value: (self node: y color: RedNode);
				  nextLink: R;
				  yourself ]
		  representation: repr
]

{ #category : #adding }
RedBlackTree >> inNilRepresentation: _ push: anObject witness: aWitness continuation: aContinuation [
	| repr |
	repr := super
		        inNilRepresentation: _
		        push: anObject
		        witness: aWitness
		        continuation: aContinuation.
	^ repr
		  value: (self node: repr value color: RedNode);
		  yourself
]

{ #category : #adding }
RedBlackTree >> is: anObject lessThan: aRefinedWitness [
	^ anObject < aRefinedWitness value
]

{ #category : #adding }
RedBlackTree >> node: x color: aColorClass [
	^ aColorClass new
		  value: x;
		  yourself
]

{ #category : #adding }
RedBlackTree >> representation: aDoubleLink [
	| repr |
	repr := aDoubleLink ifNotNil: [ 
		        aDoubleLink value: aDoubleLink value asBlackNode ].
	^ super representation: repr
]
