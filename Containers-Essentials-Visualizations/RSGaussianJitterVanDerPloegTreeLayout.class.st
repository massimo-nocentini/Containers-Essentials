Class {
	#name : #RSGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedPositioning',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedPositioning classTrait',
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #initialization }
RSGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self random: RandomBoxMullerBivariateGaussian new
]

{ #category : #positioning }
RSGaussianJitterVanDerPloegTreeLayout >> rawPositionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ super positionOfShape: aShape atDepth: depth atBreadth: breadth
]
