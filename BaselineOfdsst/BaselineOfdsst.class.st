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
			package: 'Collections-Unordered-Extensions' ]
]
