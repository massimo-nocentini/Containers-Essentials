Class {
	#name : #BaselineOfContainersEssentials,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersEssentials
}

{ #category : #baselines }
BaselineOfContainersEssentials >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals."
		self
			roassal: spec;
			gtk: spec.

		"Packages"
		spec
			package: 'Containers-Essentials';
			package: 'Containers-Essentials-Roassal';
			package: 'Containers-Essentials-Outliner';
			package: 'Containers-Essentials-Visualizations';
			package: 'Containers-Essentials-Tests' ]
]

{ #category : #baselines }
BaselineOfContainersEssentials >> gtk: spec [

	spec baseline: 'Gtk' with: [
		spec repository: 'github://pharo-spec/gtk-bindings' ";
			loads: #( Pango )" ]
]

{ #category : #baselines }
BaselineOfContainersEssentials >> roassal: spec [

	spec baseline: 'Roassal3' with: [ 
		spec
			repository: 'github://massimo-nocentini/Roassal3/src';
			loads: #( Full ) ].

	spec
		baseline: 'Roassal3Exporters'
		with: [ 
		spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ]
]
