Extension { #name : #RSHorizontalVanDerPloegTreeLayout }

{ #category : #'*Containers-Essentials-Roassal' }
RSHorizontalVanDerPloegTreeLayout >> usePyramidalHorizontalGap [

	self horizontalGap: [ :aParent :aChild :default | 
		| aPoint childrenSize i |
		aPoint := aChild propertyDfsExploreIndex key.

		i := aPoint x.
		childrenSize := aPoint y.

		i := i <= childrenSize halved ceiling
			     ifTrue: [ i ]
			     ifFalse: [ childrenSize - i + 1 ].

		i * default ]
]
