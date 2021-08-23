Class {
	#name : #BaselineOfContainersEssentialsPdm,
	#superclass : #BaselineOfContainersEssentials,
	#category : #BaselineOfContainersEssentials
}

{ #category : #'baselines-helpers' }
BaselineOfContainersEssentialsPdm >> roassal: spec [

	spec
		baseline: 'Roassal3Exporters'
		with: [ 
		spec repository: 'github://ObjectProfile/Roassal3Exporters/src' ]
]
