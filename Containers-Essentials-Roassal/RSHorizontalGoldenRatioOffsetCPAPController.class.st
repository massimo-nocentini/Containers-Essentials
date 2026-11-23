"
I am a controller of the control points of horizontal lines. I answer four of them, the two in the middle on the same vertical line, as my superclass does, but that line is not halfway: it is on the right of the start, by the horizontal distance between the two ends divided by the golden ratio.

```smalltalk
RSHorizontalGoldenRatioOffsetCPAPController new
	controlPointsFrom: 0 @ 0
	to: 100 @ 50
	""{ 0@0. 61.80339887498948@0. 61.80339887498948@50. 100@50 }""
```
"
Class {
	#name : 'RSHorizontalGoldenRatioOffsetCPAPController',
	#superclass : 'RSHorizontalCPAPController',
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'hooks' }
RSHorizontalGoldenRatioOffsetCPAPController >> controlPointsFrom: from to: to [

	^ Float goldenRatio
		  isTo: (to x - from x) abs
		  as: 1
		  isTo: [ :ratio | 
			  | x |
			  x := from x + ratio.
			  Array
				  with: from
				  with: x @ from y
				  with: x @ to y
				  with: to ]
]
