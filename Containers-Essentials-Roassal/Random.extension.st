Extension { #name : 'Random' }

{ #category : '*Containers-Essentials-Roassal' }
Random >> asShapeScatter [
	"The scatter of 500 samples of a copy of me with their densities. The copy is a deep one: Random's state (a DoubleWordArray) and KnuthRandom's (two ByteArrays) are mutable, and a shallow copy would share them, so drawing me would move my stream on"

	| gen x y |
	gen := self veryDeepCopy.
	x := ((1 to: 500) collect: [ :each1 | gen next ]) sorted.
	y := x collect: [ :each | gen density: each ].

	^ RSComposite new shapes: (RSCompositeChart new
			   add: (RSScatterPlot new
					    x: x y: y;
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new asFloat;
			   build;
			   shapes)
]
