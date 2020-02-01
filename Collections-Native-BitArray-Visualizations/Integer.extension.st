Extension { #name : #Integer }

{ #category : #'*Collections-Native-BitArray-Visualizations' }
Integer >> gtInspectorDotsUsingMondrianBuilder: aMondrian [
	| edges |
	edges := (0 to: 7)
		collect: [ :i | 
			| obj |
			obj := i -> ((1 << i bitAnd: self) >> i).
			obj -> obj ].
	edges asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape circle
				fillColor: [ :aVertex | 
					aVertex content value = 1
						ifTrue: [ Color black ]
						ifFalse: [ Color white ] ];
				borderColor: Color black
			"	shape text
				text: [ :aVertex | 
					aVertex content value = 1
						ifTrue: [ '•' ]
						ifFalse: [ '  ' ] ];
				color: Color black" ]
		edge: [ :shape |  ]
		layout: [ :layout | layout grid lineItemsCount: 8 ]
]
