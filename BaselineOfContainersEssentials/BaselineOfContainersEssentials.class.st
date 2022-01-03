Class {
	#name : #BaselineOfContainersEssentials,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersEssentials
}

{ #category : #baselines }
BaselineOfContainersEssentials >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self schmidtExtensions: spec.
		
		spec 
			baseline: 'ContainersOrderPreservingTree' 
			with: [ spec repository: 'github://bauing-schmidt/Containers-OrderPreservingTree:master/src' ].
		spec 
			baseline: 'ContainersCategory' 
			with: [ spec repository: 'github://bauing-schmidt/Containers-Category:master/src' ].
		
		self roassal: spec.
		self roassalEsporters: spec.
		self ownPackages: spec ]
]

{ #category : #baselines }
BaselineOfContainersEssentials >> ownPackages: spec [

	spec
		package: 'Containers-Essentials';
		package: 'Containers-Essentials-Roassal';
		package: 'Containers-Essentials-Outliner';
		package: 'Containers-Essentials-Visualizations';
		package: 'Containers-Essentials-Tests'
]

{ #category : #baselines }
BaselineOfContainersEssentials >> roassal: spec [

	spec

		baseline: 'Roassal3'
		with: [ 
		spec repository: 'github://bauing-schmidt/Roassal3:production10' ]
]

{ #category : #baselines }
BaselineOfContainersEssentials >> roassalEsporters: spec [

	spec
  
		baseline: 'Roassal3Exporters'
		with: [ 
		spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ]
]

{ #category : #baselines }
BaselineOfContainersEssentials >> schmidtExtensions: spec [

	spec 
		baseline: 'SchmidtExtensions' 
		with: [ spec repository: 'github://bauing-schmidt/SchmidtExtensions:master/src' ]

]
