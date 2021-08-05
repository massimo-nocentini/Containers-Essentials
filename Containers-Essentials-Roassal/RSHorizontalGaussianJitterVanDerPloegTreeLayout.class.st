Class {
	#name : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #positioning }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self initializeRSTWalkBasedRegularTreeLayoutRandomizedGaps
]
