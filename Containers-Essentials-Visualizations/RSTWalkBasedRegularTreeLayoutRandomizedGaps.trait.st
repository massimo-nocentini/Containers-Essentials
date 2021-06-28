Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedGaps,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> horizontalGap: aGap [

	self explicitRequirement
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> initializeRSTWalkBasedRegularTreeLayoutRandomizedGaps [

	| random |
	random := RandomGaussian new
		          sigma: Float goldenRatio * 3;
		          yourself.

	self
		verticalGap: [ :previousBrother :currentBrother :default | 
			random
				mu: default;
				next ];
		horizontalGap: [ :previousBrother :currentBrother :default | 
			random
				mu: default;
				next ]
]

{ #category : #initialization }
RSTWalkBasedRegularTreeLayoutRandomizedGaps >> verticalGap: aGap [

	self explicitRequirement
]
