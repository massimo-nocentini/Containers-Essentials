Class {
	#name : #RSHorizontalGoldenRatioOffsetCPAPController,
	#superclass : #RSHorizontalCPAPController,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #hooks }
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
