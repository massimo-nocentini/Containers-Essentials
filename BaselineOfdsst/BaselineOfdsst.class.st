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
						'github://massimo-nocentini/Roassal3:start-end-attach-point-controller/src' ];
			baseline: 'Roassal3Exporters'
			with: [ 
				spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ].

		"Packages"
		spec
			package: 'Kernel-Extensions';
			package: 'dsst-Traits';
			package: 'Kernel-Visualizations';
			package: 'Collections-Abstract-Extensions';
			package: 'Collections-Abstract-Visualizations';
			package: 'Collections-Native-Visualizations';
			package: 'Collections-Support-Extensions';
			package: 'Collections-Support-Visualizations';
			package: 'Collections-Strings-Extensions';
			package: 'Collections-Sequenceable-Extensions';
			package: 'Collections-Sequenceable-Visualizations';
			package: 'Collections-Unordered-Extensions' ]
]
