Class {
	#name : #RSGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps classTrait',
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #initialization }
RSGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self initializeRSTWalkBasedRegularTreeLayoutRandomizedGaps
]
