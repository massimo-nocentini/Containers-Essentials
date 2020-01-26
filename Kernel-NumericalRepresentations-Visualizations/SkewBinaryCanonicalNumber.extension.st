Extension { #name : #SkewBinaryCanonicalNumber }

{ #category : #'*Kernel-NumericalRepresentations-Visualizations' }
SkewBinaryCanonicalNumber >> gtInspectorRepresentationUsingMondrianBuilder: aMondrian [
	aMondrian shape rectangle
		fillColor: Color white;
		borderColor: Color lightGray.
	aMondrian
		nodes:
			{(representation ifNil: [ 0 ~~> nil ])	"to handle when I represent 0."}
		forEach:
			[ :aValueLink | aValueLink gtInspectorLinksUsingMondrianBuilder: aMondrian ].
	aMondrian layout horizontalLine
]

{ #category : #'*Kernel-NumericalRepresentations-Visualizations' }
SkewBinaryCanonicalNumber >> gtInspectorRepresentationViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal2
		title: 'Representation';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorRepresentationUsingMondrianBuilder: b ];
		yourself
]
