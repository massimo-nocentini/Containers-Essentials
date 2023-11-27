Class {
	#name : 'BaselineOfContainersEssentials',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersEssentials',
	#package : 'BaselineOfContainersEssentials'
}

{ #category : 'baselines' }
BaselineOfContainersEssentials >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self
			pluginsPrimitives: spec;
			roassal: spec;
			pango: spec;
			common: spec ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> common: spec [

	spec
		package: 'Containers-Essentials';
		package: 'Containers-Essentials-Roassal';
		package: 'Containers-Essentials-Outliner';
		package: 'Containers-Essentials-Visualizations';
		package: 'Containers-Essentials-Tests'
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> pango: spec [

	spec
		baseline: 'Pango'
		with: [ spec repository: 'github://massimo-nocentini/pharo-pango' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> pluginsPrimitives: spec [

	spec
		baseline: 'VMPluginsPrimitives'
		with: [ spec repository: 'github://massimo-nocentini/vm-plugins-primitives.st' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> roassal: spec [

	spec baseline: 'Roassal3' with: [ 
		spec
			repository: 'github://massimo-nocentini/Roassal3:master/src';
			loads: #( Full ) ].

	spec
		baseline: 'Roassal3Exporters'
		with: [ 
		spec repository: 'github://ObjectProfile/Roassal3Exporters:master/src' ]
]
