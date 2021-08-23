Class {
	#name : #BaselineOfContainersEssentialsPdm,
	#superclass : #BaselineOfContainersEssentials,
	#category : #BaselineOfContainersEssentialsPdm
}

{ #category : #baselines }
BaselineOfContainersEssentialsPdm >> baseline: spec [

	<baseline>
	^ super baseline: spec
]

{ #category : #'baselines-helpers' }
BaselineOfContainersEssentialsPdm >> roassal: spec [

	spec
		baseline: 'Roassal3Exporters'
		with: [ 
		spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ]
]
