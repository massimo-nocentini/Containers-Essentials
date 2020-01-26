Extension { #name : #BinomialTree }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges [
	^ self edges: content -> content ~~> nil
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> edges: incomingEdges [
	^ children asLinkedList
		foldr: [ :each :acc | each edges: content -> each content ~~> acc ]
		init: incomingEdges
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialTree >> gtInspectorTreeUsingMondrianBuilder: aMondrian [
	self edges asLinkedList asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: #content;
				color: Color black ]
		edge: [ :shape | shape orthoVerticalLine ]
		layout: #tree
]
