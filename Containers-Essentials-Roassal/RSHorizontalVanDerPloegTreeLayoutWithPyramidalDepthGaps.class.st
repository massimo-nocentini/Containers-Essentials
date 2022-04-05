Class {
	#name : #RSHorizontalVanDerPloegTreeLayoutWithPyramidalDepthGaps,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #accessing }
RSHorizontalVanDerPloegTreeLayoutWithPyramidalDepthGaps >> horizontalGapAmongParent: aParent andChild: aChild [

	^ self
		  gapAmongParent: aParent
		  andChild: aChild
		  default:
		  (super horizontalGapAmongParent: aParent andChild: aChild)
]
