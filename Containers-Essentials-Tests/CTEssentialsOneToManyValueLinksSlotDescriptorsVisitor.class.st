Class {
	#name : 'CTEssentialsOneToManyValueLinksSlotDescriptorsVisitor',
	#superclass : 'CTSlotDescriptorsVisitor',
	#category : 'Containers-Essentials-Tests-SUTs',
	#package : 'Containers-Essentials-Tests',
	#tag : 'SUTs'
}

{ #category : 'visiting' }
CTEssentialsOneToManyValueLinksSlotDescriptorsVisitor >> visitCTDummyForOneToMany: aDummy [

	^ { (self newSlotDescriptorSelector: #collection) oneToMany }
]

{ #category : 'visiting' }
CTEssentialsOneToManyValueLinksSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ (super visitValueLink: aValueLink) yourself: [ :descriptors | 
		  descriptors first oneToMany ]
]
