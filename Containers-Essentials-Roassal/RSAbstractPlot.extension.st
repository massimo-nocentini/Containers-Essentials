Extension { #name : 'RSAbstractPlot' }

{ #category : '*Containers-Essentials-Roassal' }
RSAbstractPlot >> points: aCollectionOfPoints [

	| x y |
	x := Array new: aCollectionOfPoints size.
	y := Array new: aCollectionOfPoints size.

	aCollectionOfPoints withIndexDo: [ :each :index | 
		x at: index put: each x.
		y at: index put: each y ].

	^ self x: x y: y
]
