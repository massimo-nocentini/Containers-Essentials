Extension { #name : #SBRAL }

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> associations [
	^ representation
		ifNotNil: [ ValueLink new
				value: representation value;
				nextLink: self cdr associations;
				yourself ]
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
	"aMondrian shape arrowedLine withShorterDistanceAttachPoint.
	aMondrian edges
		connectTo:
			[ :aPromise | aPromise ifEager: [ :aValue | aValue nextLink promise ] ifLazy: [  ] ]."
	aMondrian layout verticalLine
]

{ #category : #'*Collections-Sequenceable-SBRAL-Visualizations' }
SBRAL >> gtInspectorTreesViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Trees';
		initializeView: [ RTMondrian new ];
		painting: [ :b | 
			self gtInspectorTreesUsingMondrianBuilder: b.
			b
				build;
				view ];
		yourself
]
