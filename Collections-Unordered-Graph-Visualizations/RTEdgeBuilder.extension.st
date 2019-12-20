Extension { #name : #RTEdgeBuilder }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RTEdgeBuilder >> createEdgeIfNecessaryFrom: fromElement to: toElement model: model [
	"This is a private method. Create, if necessary, an edge between two elements"

	(self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ createdEdges
				add: (self edgeFrom: fromElement to: toElement model: model) ]
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RTEdgeBuilder >> edgeFrom: source to: target model: model [
	"source and target are elements"

	| edge |
	edge := super edgeFrom: source to: target.
	edge model: model.
	shouldNotBeUsedInLayout
		ifFalse: [ edge notUseInLayout ].
	self processEdge: edge.
	^ edge
]

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RTEdgeBuilder >> source: objects connectFrom: fromblock withModelTo: toBlock [
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

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RTEdgeBuilder >> useAssociationModelTuples: tuples [
	| fromElement toElement |
	createdEdges := RTGroup new.
	tuples
		do: [ :tuple | 
			| assoc model |
			assoc := tuple first.
			model := tuple second.
			fromElement := self fromElements elementFromModel: assoc key.
			toElement := self toElements elementFromModel: assoc value.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [ self
						createEdgeIfNecessaryFrom: fromElement
						to: toElement
						model: model ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]
