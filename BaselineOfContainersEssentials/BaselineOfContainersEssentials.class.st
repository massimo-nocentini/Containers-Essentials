Class {
	#name : #BaselineOfContainersEssentials,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersEssentials
}

{ #category : #baselines }
BaselineOfContainersEssentials >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals."
		spec
			baseline: 'Roassal3'
			with: [ spec repository: 'github://massimo-nocentini/Roassal3/src' ];
			baseline: 'Roassal3Exporters'
			with: [ 
				spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ].

		"Packages"
		spec
			package: 'Kernel-Extensions';
			package: 'Containers-Essentials';
			package: 'Containers-Essentials-Roassal';
			package: 'Containers-Essentials-Visualizations';
			package: 'Containers-Essentials-Tests';
			package: 'Collections-Abstract-Extensions';
			package: 'Collections-Strings-Extensions';
			package: 'Collections-Sequenceable-Extensions' ]
]
