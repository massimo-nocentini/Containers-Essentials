Class {
	#name : #RSGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #initialization }
RSGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self bothVerticalAndHorizontalGapsUseRandomGaussian:
		((RandomGaussian seed: 541)
			 sigma: Float goldenPlatinumRatio;
			 yourself)
]
