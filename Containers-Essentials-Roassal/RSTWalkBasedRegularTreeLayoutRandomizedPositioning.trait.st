Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedPositioning,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ self
		  positionOfShape: aShape
		  atDepth: depth
		  atBreadth: breadth
		  random:
		  self rsTWalkBasedRegularTreeLayoutRandomizedPositioningRandom
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> positionOfShape: aShape atDepth: depth atBreadth: breadth random: aRandom [

	self explicitRequirement
]

{ #category : #accessing }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> rsTWalkBasedRegularTreeLayoutRandomizedPositioningRandom [

	self explicitRequirement
]
