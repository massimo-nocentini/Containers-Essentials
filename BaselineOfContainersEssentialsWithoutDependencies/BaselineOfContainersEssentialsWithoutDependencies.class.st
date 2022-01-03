Class {
	#name : #BaselineOfContainersEssentialsWithoutDependencies,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersEssentialsWithoutDependencies
}

{ #category : #baselines }
BaselineOfContainersEssentialsWithoutDependencies >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self ownPackages: spec ]
]

{ #category : #baselines }
BaselineOfContainersEssentialsWithoutDependencies >> ownPackages: spec [

	spec
		package: 'Containers-Essentials';
		package: 'Containers-Essentials-Roassal';
		package: 'Containers-Essentials-Outliner';
		package: 'Containers-Essentials-Visualizations';
		package: 'Containers-Essentials-Tests'
]
