Class {
	#name : #BaselineOfContainersEssentials,
	#superclass : #BaselineOf,
	#category : #BaselineOfdsst
}

{ #category : #baselines }
BaselineOfContainersEssentials >> baseline: spec [

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
			package: 'Containers-Essentials';
			package: 'Containers-Essentials-Visualizations';
			package: 'Collections-Abstract-Extensions';
			package: 'Collections-Support-Extensions';
			package: 'Collections-Support-Visualizations';
			package: 'Collections-Strings-Extensions';
			package: 'Collections-Sequenceable-Extensions';
			package: 'Collections-Sequenceable-Visualizations' ]
]