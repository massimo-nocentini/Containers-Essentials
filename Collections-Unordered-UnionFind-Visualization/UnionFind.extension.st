Extension { #name : #UnionFind }

{ #category : #'*Collections-Unordered-UnionFind-Visualization' }
UnionFind >> gtInspectorGraphViewIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite roassal2
		title: 'Sets';
		initializeView: [ RTMondrian new ];
		painting: [ :mondrian | 
			dict associations asGraph
				gtInspectorGraphViewUsingMondrianBuilder: mondrian
				vertex: [ :shape | 
					shape text
						text:
								[ :aVertex | String streamContents: [ :s | self printOn: s key: aVertex content ] ];
						color: Color black ]
				edge: [ :shape | shape arrowedBezier shortestDistanceAttachPointWithJump ]
				layout: [ :layout | 
					layout tree
						verticalGap: 100;
						yourself ] ];
		yourself
]
