Class {
	#name : #CTEssentialsOneToManyValueLinksSlotDescriptorsVisitor,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
CTEssentialsOneToManyValueLinksSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ (super visitValueLink: aValueLink) yourself: [ :descriptors | 
		  descriptors first oneToMany ]
]
