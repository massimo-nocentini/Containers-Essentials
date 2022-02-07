Class {
	#name : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps',
	#classTraits : 'RSTWalkBasedRegularTreeLayoutRandomizedGaps classTrait',
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #initialization }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	self bothVerticalAndHorizontalGapsUseRandomGaussian:
		((RandomGaussian seed: 541)
			 sigma: Float goldenPlatinumRatio;
			 yourself)
]
