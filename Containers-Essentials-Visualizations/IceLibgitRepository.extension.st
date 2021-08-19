Extension { #name : #IceLibgitRepository }

{ #category : #'*Containers-Essentials-Visualizations' }
IceLibgitRepository >> asShapeCommitsGraph [

	| commits edges dict |
	dict := Dictionary new.

	self allBranches do: [ :aBranch | 
		(self newCommitWalk fromBranch: aBranch) commits do: [ :aCommit | 
			| circle |
			circle := RSCircle new
				          model: aCommit id asSymbol;
				          "radius:
						           ((aCommit changesTo: aCommit parent) size / Float pi)
							           sqrt;"
				          color: Color white;
				          draggable;
				          addInteraction: (RSPopup new text: [ 
							           String streamContents: [ :aStream | 
									           aStream
										           nextPutAll: aCommit comment;
										           cr;
										           cr;
										           nextPutAll: aCommit shortId;
										           nextPutAll: ' -- by ';
										           nextPutAll: aCommit author;
										           nextPutAll: ' at ';
										           nextPutAll: aCommit datetime asLocalStringYMDHM;
										           nextPutAll: '.' ] ]);
				          withBorder;
				          yourself.

			circle propertyAt: #gitCommit put: aCommit.

			aCommit isMergeCommit ifTrue: [ circle color: circle border color ].

			dict at: aCommit id put: circle ] ].

	commits := dict values.

	edges := RSLineBuilder verticalBezier
		         shapes: commits;
		         withVerticalAttachPoint;
		         connectToAll: [ :aCommitId | 
			         ((dict at: aCommitId) propertyAt: #gitCommit) ancestorIds ].

	edges sort: [ :a :b | 
		| aTime bTime |
		aTime := (a to propertyAt: #gitCommit) datetime.
		bTime := (b to propertyAt: #gitCommit) datetime.
		aTime > bTime
			ifTrue: [ true ]
			ifFalse: [ 
				aTime = bTime
					ifTrue: [ 
						(a from propertyAt: #gitCommit) datetime
						> (b from propertyAt: #gitCommit) datetime ]
					ifFalse: [ false ] ] ].

	RSVanDerPloegTreeLayout new
		doNotValidateCycles;
		verticalGap: [ :parent :child :default | 
			| duration goldenRatio |
			goldenRatio := 1.61803398875.
			duration := (parent propertyAt: #gitCommit) datetime
			            - (child propertyAt: #gitCommit) datetime.
			self assert: duration asSeconds >= 0.
			((duration asMinutes max: goldenRatio) log: goldenRatio)
			* goldenRatio ];
		on: commits edges: edges.



	edges do: [ :each | 
		"self assert: each to encompassingRectangle top
			>= each from encompassingRectangle bottom."

		(each to propertyAt: #vdpLevel) - (each from propertyAt: #vdpLevel)
		> 1 ifTrue: [ 
			each
				dashArray: #( 4 );
				color: each color translucent";
				pushBack" ] ].

	^ RSComposite new
		  model: self;
		  shapes: commits , edges;
		  yourself
]
