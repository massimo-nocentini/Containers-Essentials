Class {
	#name : #RSGaussianJitterVanDerPloegTreeLayout,
	#superclass : #RSVanDerPloegTreeLayout,
	#instVars : [
		'random'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #initialization }
RSGaussianJitterVanDerPloegTreeLayout >> initialize [

	super initialize.

	random := RandomBoxMullerBivariateGaussian new
]

{ #category : #positioning }
RSGaussianJitterVanDerPloegTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ (super positionOfShape: aShape atDepth: depth atBreadth: breadth)
	  + (random next * Float goldenRatio)
]
