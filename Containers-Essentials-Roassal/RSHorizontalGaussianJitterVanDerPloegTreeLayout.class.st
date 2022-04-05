Class {
	#name : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsGaussian',
	#classTraits : 'RSTWalkBasedRegularTreeGapsGaussian classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #accessing }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> horizontalGapAmongParent: aParent andChild: aChild [

	^ self
		  gapAmond: aParent
		  and: aChild
		  default:
		  (super horizontalGapAmongParent: aParent andChild: aChild)
]

{ #category : #initialization }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self initializeRandomGaussianMu: 0 sigma: Float goldenRatio
]
