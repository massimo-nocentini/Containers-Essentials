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
		do: [ "Packages"
			spec
				package: 'Kernel-Extensions';
				package: 'Collections-Sequenceable-Extensions';
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
				package: 'Collections-Sequenceable-Cons' ]
]
