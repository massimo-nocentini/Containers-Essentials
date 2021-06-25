Class {
	#name : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedPositioning',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedPositioning classTrait',
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #positioning }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self random: RandomBoxMullerBivariateGaussian new
]

{ #category : #positioning }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> rawPositionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ super positionOfShape: aShape atDepth: depth atBreadth: breadth
]
