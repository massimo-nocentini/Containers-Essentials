Class {
	#name : #RSHorizontalGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#instVars : [
		'random'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #positioning }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	random := RandomBoxMullerBivariateGaussian new
]

{ #category : #positioning }
RSHorizontalGaussianJitterVanDerPloegTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ (super positionOfShape: aShape atDepth: depth atBreadth: breadth)
	  + (random next * Float goldenRatio)
]
