"
I am a visitor that describes as one-to-many the slots `collection` of a `CTDummyForOneToMany` and `value` of a `ValueLink`: the lines of the slot go to the elements of the collection in it, which has no outliner of its own. None of the elements can be one that is drawn inline, such as a number: the painter signals `KeyNotFound` then.
"
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
