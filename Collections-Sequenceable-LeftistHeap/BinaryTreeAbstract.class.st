Class {
	#name : #BinaryTreeAbstract,
	#superclass : #CTDoubleValueLink,
	#category : #'Collections-Sequenceable-LeftistHeap'
}

{ #category : #comparing }
BinaryTreeAbstract >> = anotherObject [
	^ self == anotherObject
]

{ #category : #converting }
BinaryTreeAbstract >> asSlotsGroupKnownReferences: aSet recursiveReferences: refs [
	^ self
		  asSlotsGroupKnownReferences: aSet
		  recursiveReferences: refs
		  layoutBlock: [ :shapes | 
			  | eb |
			  eb := (RSEdgeBuilder new: RSArrowedLine new)
				        color: Color gray;
				        shapes: shapes;
				        yourself.
			  RSTreeLayout
				  on: shapes
				  edges: (eb connectTo: #previousLink) , (eb connectTo: #nextLink) ]
]

{ #category : #comparing }
BinaryTreeAbstract >> hash [
	^ self identityHash
]

{ #category : #'as yet unclassified' }
BinaryTreeAbstract >> recursiveReferences [
	| stack |
	stack := CTLinkedStoragePool stack new.
	stack push: self.
	^ Array streamContents: [ :s | 
		  [ stack isEmpty ] whileFalse: [ 
			  | node |
			  node := stack pop.
			  s nextPut: node.
			  node previousLink ifNotNil: [ :l | stack push: l ].
			  node nextLink ifNotNil: [ :l | stack push: l ] ] ]
]
