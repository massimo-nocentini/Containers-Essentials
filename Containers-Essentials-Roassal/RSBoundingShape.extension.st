Extension { #name : 'RSBoundingShape' }

{ #category : '*Containers-Essentials-Roassal' }
RSBoundingShape >> extent: aPoint [

	| oldExtent extent |
	extent := baseRectangle extent.
	extent = aPoint ifTrue: [ ^ self ].
	self assert: aPoint isPoint.
	oldExtent := extent.
	baseRectangle := Rectangle center: 0 @ 0 extent: aPoint.
	self
		resetBBox;
		resetPath.
	self announce: (RSExtentChangedEvent new
			 shape: self;
			 oldExtent: oldExtent;
			 newExtent: extent;
			 yourself)
]
