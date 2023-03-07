Class {
	#name : #BaselineOfContainersEssentialsGTK,
	#superclass : #BaselineOfContainersEssentials,
	#category : #BaselineOfContainersEssentials
}

{ #category : #baselines }
BaselineOfContainersEssentialsGTK >> common: spec [

	super common: spec.

	spec package: 'Containers-Essentials-Gtk'
]

{ #category : #baselines }
BaselineOfContainersEssentialsGTK >> gtk: spec [

	spec baseline: 'Gtk' with: [
		spec repository: 'github://pharo-spec/gtk-bindings' ";
			loads: #( Pango )" ]
]
