Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> gtInspectorRoassalItemsIn: composite [
	<gtInspectorPresentationOrder: 20>
	"^ composite roassal2
		title: 'Graph';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorRoassalItemsUsingMondrianBuilder: b ];
		yourself"
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> gtInspectorRoassalItemsUsingMondrianBuilder: aMondrian [
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray;
		withTextOnTheLeft: #key.
	aMondrian
		nodes: (self collectWithIndex: [ :each :index | index -> each ])
		forEach: [ :anAssociation | 
			anAssociation value
				gtInspectorItemInSequenceableCollection: self
				at: anAssociation key
				usingMondrianBuilder: aMondrian ].
	aMondrian layout verticalLine
]
