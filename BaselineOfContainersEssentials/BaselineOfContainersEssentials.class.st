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
			containers: spec;
			roassal: spec;
			pluginsPrimitives: spec;
			pango: spec;
			common: spec;
			poppler: spec ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> common: spec [
	"Containers-Essentials needs Roassal-Utils of RoassalMN (exponentiallyWeighted:init:, Interval>>#unitAt:) and extends CTArray2D"

	spec
		package: 'Containers-Essentials'
		with: [ spec requires: #( 'ContainersArray2D' 'RoassalMN' ) ];
		package: 'Containers-Essentials-Roassal' with: [
			spec requires:
					#( 'RoassalMN' 'LibPangoCairo' 'Containers-Essentials' ) ];
		package: 'Containers-Essentials-UML' with: [
			spec requires:
					#( 'RoassalMN' 'Containers-Essentials' 'Containers-Essentials-Roassal' ) ];
		package: 'Containers-Essentials-Outliner'
		with: [ spec requires: #( 'Containers-Essentials-Roassal' ) ];
		package: 'Containers-Essentials-Visualizations'
		with: [ spec requires: #( 'Containers-Essentials-Outliner' ) ];
		package: 'Containers-Essentials-Tests' with: [
			spec requires:
					#( 'Containers-Essentials-Visualizations' 'Containers-Essentials-UML' ) ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> containers: spec [

	spec
		baseline: 'ContainersArray2D'
		with: [
		spec repository: 'github://pharo-containers/Containers-Array2D/src' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> pango: spec [

	spec
		baseline: 'LibPangoCairo'
		with: [
		spec repository: 'github://massimo-nocentini/libpangocairo.st:master/src' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> pluginsPrimitives: spec [

	spec
		baseline: 'VMPluginsPrimitives'
		with: [
			spec repository:
				'github://massimo-nocentini/vm-plugins-primitives.st:master/src' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> poppler: spec [
	"The same repository description as BaselineOfBookletDSst's (<repository>:<default branch>/<source directory>, as the other projects here), so that loading both does not give Metacello two descriptions of LibPoppler"

	spec
		baseline: 'LibPoppler'
		with: [
		spec repository: 'github://massimo-nocentini/libpoppler.st:master/src' ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> roassal: spec [
	"The group Full of RoassalMN loads the group Core of RoassalExporters (github://massimo-nocentini/RoassalExporters:master/src), which is its default group"

	spec baseline: 'RoassalMN' with: [
		spec
			repository: 'github://massimo-nocentini/Roassal:Pharo15/src';
			loads: #( Full ) ]
]
