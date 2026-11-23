"
I am the baseline of [Containers-Essentials](https://github.com/massimo-nocentini/Containers-Essentials). My packages are:

- `Containers-Essentials`: extension methods of Pharo's classes, and classes for numbers (`Complex`, the divisions and greatest common divisors of integers, the skew binary numbers), collections, conditions and messages.
- `Containers-Essentials-Roassal`: attach points and control points for Roassal's lines, a camera setter with a padding, and the trait `TIceImagesExporting`.
- `Containers-Essentials-Outliner`: the outliners, which draw the graph of the objects reachable from an object, and the notebooks.
- `Containers-Essentials-Visualizations`: extension methods that draw objects of Pharo and Roassal.
- `Containers-Essentials-Tests`: the tests.

I depend on the projects `ContainersArray2D`, `RoassalMN` (its group `Full`), `VMPluginsPrimitives`, `LibPangoCairo` and `LibPoppler`. Load me with:

```smalltalk
[ Metacello new
	baseline: 'ContainersEssentials';
	repository:
		'github://massimo-nocentini/Containers-Essentials';
	load ]
	on: MCMergeOrLoadWarning
	do: [ :warning | warning load ]
```

After the load, `postLoadAfterUMLMove` removes the package `Containers-Essentials-UML` if it is empty, as its classes and methods are in `RoassalMN` now, and signals an error if the `RoassalMN` in the image does not have them.
"
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
	"The sequence diagrams went back from Containers-Essentials-UML to Roassal-UML of RoassalMN. Metacello does not unload a package dropped from a baseline, so an image upgraded from a Containers-Essentials that had it keeps it, empty and modified.
	An upgrade of Containers-Essentials alone (a locked or older RoassalMN is not reloaded) removes the helpers that went to Roassal-Utils and leaves the sequence diagrams in Containers-Essentials-UML, without any error: fail loudly instead"

	self removeUMLPackageIfEmpty.
	self roassalMNHasTheSequenceDiagrams ifFalse: [
		self error:
			'Containers-Essentials needs the RoassalMN whose Roassal-UML has the sequence diagrams: load RoassalMN again, then Containers-Essentials' ]
]

{ #category : 'doits' }
BaselineOfContainersEssentials >> removeUMLPackageIfEmpty [
	"Remove the package Containers-Essentials-UML (and its working copy) once RoassalMN took all its classes and methods. A package that still has some is left alone"

	(PackageOrganizer default
		 packageNamed: 'Containers-Essentials-UML'
		 ifAbsent: [ nil ]) ifNotNil: [ :package |
		package isEmpty ifTrue: [ package removeFromSystem ] ]
]

{ #category : 'doits' }
BaselineOfContainersEssentials >> roassalMNHasTheSequenceDiagrams [
	"Whether the RoassalMN in the image has the sequence diagrams in Roassal-UML and the helpers of Containers-Essentials in Roassal-Utils (Integer>>#asStringaz among them)"

	^ ((Smalltalk globals at: #RSUMLSequenceBuilder ifAbsent: [ nil ])
		   ifNil: [ false ]
		   ifNotNil: [ :class | class package name = 'Roassal-UML' ]) and: [
		  Integer includesSelector: #asStringaz ]
]

{ #category : 'baselines' }
BaselineOfContainersEssentials >> roassal: spec [
	"The group Full of RoassalMN loads the group Core of RoassalExporters (github://massimo-nocentini/RoassalExporters:master/src), which is its default group"

	spec baseline: 'RoassalMN' with: [
		spec
			repository: 'github://massimo-nocentini/Roassal:Pharo15/src';
			loads: #( Full ) ]
]
