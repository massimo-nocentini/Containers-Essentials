Class {
	#name : #RSHorizontalGoldenRatioOffsetCPAPController,
	#superclass : #RSHorizontalCPAPController,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #hooks }
RSHorizontalGoldenRatioOffsetCPAPController >> controlPointsFrom: from to: to [

	| x |
	x := from x + Float goldenRatio double double.
	^ Array
		  with: from
		  with: x @ from y
		  with: x @ to y
		  with: to
]
