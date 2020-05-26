Extension { #name : #RSEdgeBuilder }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RSEdgeBuilder >> createEdgeIfNecessaryFrom: fromElement to: toElement model: model [
	"This is a private method. Create, if necessary, an edge between two elements"

	(self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ createdEdges
				add: (self edgeFrom: fromElement to: toElement model: model) ]
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RSEdgeBuilder >> edgeFrom: source to: target model: model [
	"source and target are elements"

	| edge |
	edge := super edgeFrom: source to: target.
	edge model: model.
	self processEdge: edge.
	^ edge
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RSEdgeBuilder >> source: objects connectFrom: fromblock withModelTo: toBlock [
	| tuples allObjects |
	self
		assert: [ objects notNil ]
		description: 'Cannot provide a nil value as the source'.
	self
		assert: [ objects isCollection ]
		description: 'Need to provide a collection as the source'.
	allObjects := Set new.
	tuples := objects
		collect: [ :o | 
			| f t |
			f := fromblock rtValue: o.
			t := toBlock rtValue: o.
			allObjects
				add: f;
				add: t.
			Array with: f -> t with: o ].
	self objects: allObjects asArray.
	^ self useAssociationModelTuples: tuples
]
