Extension { #name : #BinomialHeap }

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> associations [
	^ self associations: representation
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> associations: aValueLink [
	^ aValueLink
		ifNotNil: [ aValueLink value ~~> (self associations: aValueLink nextLink) ]
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> gtInspectorTreesUsingMondrianBuilder: aMondrian [
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray;
		withTextAbove: #key.
	aMondrian
		nodes: self associations asLinkedList
		forEach:
			[ :anAssociation | anAssociation value gtInspectorTreeUsingMondrianBuilder: aMondrian ].
	aMondrian layout verticalLine
]

{ #category : #'*Collections-Sequenceable-BinomialHeap-Visualizations' }
BinomialHeap >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Trees';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorTreesUsingMondrianBuilder: b ];
		yourself
]
