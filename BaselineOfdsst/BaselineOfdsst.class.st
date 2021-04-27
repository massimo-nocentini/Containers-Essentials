Class {
	#name : #BaselineOfdsst,
	#superclass : #BaselineOf,
	#category : #BaselineOfdsst
}

{ #category : #baselines }
BaselineOfdsst >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals."
		spec
			baseline: 'Roassal3' with: [ 
				spec repository:
						'github://massimo-nocentini/Roassal3:recursiveShapeFromModel/src' ];
			baseline: 'Roassal3Exporters'
			with: [ 
				spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ].

		"Packages"
		spec
			package: 'Kernel-Extensions';
			package: 'dsst-Traits';
			package: 'Slot-Examples-Extensions';
			package: 'Kernel-Visualizations';
			package: 'Collections-Abstract-Extensions';
			package: 'Collections-Abstract-Visualizations';
			package: 'Collections-Native-Visualizations'
			with: [ spec requires: #( 'Kernel-Visualizations' ) ];
			package: 'Collections-Support-Extensions';
			package: 'Collections-Support-Visualizations';
			package: 'Collections-Strings-Extensions';
			package: 'Collections-Sequenceable-Extensions';
			package: 'Collections-Sequenceable-Visualizations';
			package: 'Collections-Unordered-Maybe';
			"Graphs."package: 'Collections-Unordered-Graph';
			package: 'Collections-Unordered-Graph-Tests'
			with: [ spec requires: #( 'Collections-Unordered-Graph' ) ];
			package: 'Collections-Unordered-Graph-Visualizations'
			with: [ spec requires: #( 'Collections-Unordered-Graph' ) ];
			package: 'Collections-Sequenceable-Cons';
			package: 'Collections-Sequenceable-Cons-Tests';
			package: 'Collections-Sequenceable-Queue';
			package: 'Collections-Sequenceable-Queue-Visualizations';
			package: 'Collections-Unordered-Extensions' ]
]
