Class {
	#name : #BaselineOfdsst,
	#superclass : #BaselineOf,
	#category : #BaselineOfdsst
}

{ #category : #baselines }
BaselineOfdsst >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Externals."
			"spec
				baseline: 'Roassal2'
				with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ]."
			"Packages"
			spec
				package: 'Kernel-Extensions';
				package: 'Collections-Support-Extensions';
				package: 'Collections-String-Extensions';
				package: 'Collections-Sequenceable-Extensions';
				package: 'Roassal2-Core-Extensions';
				package: 'Collections-Unordered-Maybe';
				package: 'Kernel-NumericalRepresentations';
				package: 'Collections-Sequenceable-Sorting'
					with: [ spec requires: #('Collections-Sequenceable-Extensions') ];
				"Graphs."
					package: 'Collections-Unordered-Graph';
				package: 'Collections-Unordered-Graph-Tests'
					with: [ spec requires: #('Collections-Unordered-Graph') ];
				package: 'Collections-Unordered-Graph-Visualizations'
					with: [ spec requires: #('Collections-Unordered-Graph') ];
				"UnionFind."
					package: 'Collections-Unordered-UnionFind';
				package: 'Collections-Unordered-UnionFind-Tests'
					with: [ spec requires: #('Collections-Unordered-UnionFind') ];
				package: 'Collections-Unordered-UnionFind-Visualizations'
					with: [ spec
						requires:
							#('Collections-Unordered-UnionFind' 'Collections-Sequenceable-Extensions') ];
				package: 'Collections-Sequenceable-Cons';
				package: 'Collections-Sequenceable-LeftistHeap';
				package: 'Collections-Sequenceable-LeftistHeap-Tests'
					with: [ spec
						requires:
							#('Collections-Sequenceable-LeftistHeap' 'Collections-Support-Extensions' 'Roassal2-Core-Extensions') ];
				package: 'Collections-Sequenceable-LeftistHeap-Visualizations'
					with: [ spec requires: #('Collections-Sequenceable-LeftistHeap') ];
				package: 'Collections-Sequenceable-SBRAL';
				package: 'Collections-Sequenceable-SBRAL-Visualizations'
					with: [ spec requires: #('Collections-Sequenceable-SBRAL') ] ]
]
