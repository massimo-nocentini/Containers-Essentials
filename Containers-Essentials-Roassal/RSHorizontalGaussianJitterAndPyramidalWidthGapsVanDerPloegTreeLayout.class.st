Class {
	#name : #RSHorizontalGaussianJitterAndPyramidalWidthGapsVanDerPloegTreeLayout,
	#superclass : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #accessing }
RSHorizontalGaussianJitterAndPyramidalWidthGapsVanDerPloegTreeLayout >> horizontalGapAmongParent: aParent andChild: aChild [

	^ self
		  gapAmongParent: aParent
		  andChild: aChild
		  default:
		  (super horizontalGapAmongParent: aParent andChild: aChild)
]
