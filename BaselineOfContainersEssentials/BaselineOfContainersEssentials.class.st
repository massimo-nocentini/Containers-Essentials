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
		baseline: 'LibPangoCairo'
		with: [ spec repository: 'github://massimo-nocentini/libpangocairo.st' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> pluginsPrimitives: spec [

	spec
		baseline: 'VMPluginsPrimitives'
		with: [ spec repository: 'github://massimo-nocentini/vm-plugins-primitives.st' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> roassal: spec [

	spec baseline: 'Roassal' with: [ 
		spec
			repository: 'github://massimo-nocentini/Roassal:master/src';
			loads: #( Full ) ].

	spec
		baseline: 'RoassalExporters'
		with: [ 
		spec repository: 'github://massimo-nocentini/RoassalExporters:master/src' ]
]
