Extension { #name : #RSHorizontalVanDerPloegTreeLayout }

{ #category : #'*Containers-Essentials-Roassal' }
RSHorizontalVanDerPloegTreeLayout >> usePyramidalDepthGaps [

	self horizontalGap: [ :aParent :aChild :default | 
		| childrenSize i |
		i := self childIndexOf: aChild.
		childrenSize := (self siblingsOf: aChild) size.

		i := i <= childrenSize halved ceiling
			     ifTrue: [ i ]
			     ifFalse: [ childrenSize - i + 1 ].

		i * default ]
]
