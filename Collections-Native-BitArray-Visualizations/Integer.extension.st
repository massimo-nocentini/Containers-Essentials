Extension { #name : #Integer }

{ #category : #'*Collections-Native-BitArray-Visualizations' }
Integer >> gtInspectorDotsBlanksMaybe: aMaybe usingMondrianBuilder: aMondrian [
	| edges split |
	split := aMaybe
		ifNothing: [ 7 ]
		ifJust: [ :aJust | 7 - aJust content ].
	edges := (0 to: 7)
		collect: [ :i | 
			| obj |
			obj := i -> ((i <= split) -> ((1 << i bitAnd: self) >> i)).
			obj -> obj ].
	edges asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape circle
				fillColor: [ :aVertex | 
					| assoc |
					assoc := aVertex content value.
					assoc key
						ifTrue: [ assoc value = 1
								ifTrue: [ Color black ]
								ifFalse: [ Color white ] ]
						ifFalse: [ Color gray ] ];
				borderColor: [ :aVertex | 
					| assoc |
					assoc := aVertex content value.
					assoc key
						ifTrue: [ Color black ]
						ifFalse: [ Color gray ] ] ]
		edge: [ :shape |  ]
		layout: [ :layout | layout grid lineItemsCount: 8 ]
]
