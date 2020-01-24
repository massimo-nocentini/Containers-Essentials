Extension { #name : #SBRAL }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> associations [
	^ representation
		ifNotNil: [ representation value ~~> self cdr associations ]
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> gtInspectorTreesUsingMondrianBuilder: aMondrian [
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

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Trees';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorTreesUsingMondrianBuilder: b ];
		yourself
]
