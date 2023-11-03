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
BaselineOfContainersEssentials >> roassal: spec [

	spec baseline: 'Roassal' with: [ 
		spec
			repository: 'github://massimo-nocentini/Roassal3:master/src';
			loads: #( Full ) ].

	"spec
		baseline: 'RoassalExporters'
		with: [ 
		spec repository: 'github://massimo-nocentini/RoassalExporters:master/src' ]"
]
