Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedGaps,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> bothVerticalAndHorizontalGapsUseRandomGaussian: aRandom [

	self
		verticalGap: [ :previousBrother :currentBrother :default | 
			aRandom
				mu: default;
				next ];
		horizontalGap: [ :previousBrother :currentBrother :default | 
			aRandom
				mu: default;
				next ]
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> horizontalGap: aGap [

	self explicitRequirement
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> verticalGap: aGap [

	self explicitRequirement
]
