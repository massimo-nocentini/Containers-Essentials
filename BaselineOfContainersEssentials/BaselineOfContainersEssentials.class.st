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
		spec postLoadDoIt: #postLoadAfterUMLMove.
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
	"Containers-Essentials needs Roassal-Utils of RoassalMN (exponentiallyWeighted:init:, Interval>>#unitAt:, scan:init:, asStringaz...) and extends CTArray2D. The UML sequence diagrams (RSUMLSequenceBuilder) are in Roassal-UML of RoassalMN"

	spec
		package: 'Containers-Essentials'
		with: [ spec requires: #( 'ContainersArray2D' 'RoassalMN' ) ];
		package: 'Containers-Essentials-Roassal' with: [
			spec requires:
					#( 'RoassalMN' 'LibPangoCairo' 'Containers-Essentials' ) ];
		package: 'Containers-Essentials-Outliner'
		with: [ spec requires: #( 'Containers-Essentials-Roassal' ) ];
		package: 'Containers-Essentials-Visualizations'
		with: [ spec requires: #( 'Containers-Essentials-Outliner' ) ];
		package: 'Containers-Essentials-Tests'
		with: [ spec requires: #( 'Containers-Essentials-Visualizations' ) ]
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

{ #category : 'doits' }
BaselineOfContainersEssentials >> postLoadAfterUMLMove [
	"The sequence diagrams went back from Containers-Essentials-UML to Roassal-UML of RoassalMN. Metacello does not unload a package dropped from a baseline, so an image upgraded from a Containers-Essentials that had it keeps it, empty and modified"

	self removeUMLPackageIfEmpty
]

{ #category : 'doits' }
BaselineOfContainersEssentials >> removeUMLPackageIfEmpty [
	"Remove the package Containers-Essentials-UML (and its working copy) once RoassalMN took all its classes and methods. A package that still has some is left alone"

	(PackageOrganizer default
		 packageNamed: 'Containers-Essentials-UML'
		 ifAbsent: [ nil ]) ifNotNil: [ :package |
		package isEmpty ifTrue: [ package removeFromSystem ] ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> roassal: spec [
	"The group Full of RoassalMN loads the group Core of RoassalExporters (github://massimo-nocentini/RoassalExporters:master/src), which is its default group"

	spec baseline: 'RoassalMN' with: [
		spec
			repository: 'github://massimo-nocentini/Roassal:Pharo15/src';
			loads: #( Full ) ]
]
