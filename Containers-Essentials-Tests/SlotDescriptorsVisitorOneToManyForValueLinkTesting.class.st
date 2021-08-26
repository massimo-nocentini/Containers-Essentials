Class {
	#name : #SlotDescriptorsVisitorOneToManyForValueLinkTesting,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
SlotDescriptorsVisitorOneToManyForValueLinkTesting >> visitValueLink: aValueLink [

	^ (super visitValueLink: aValueLink) yourself: [ :descriptors | 
		  descriptors first oneToMany ]
]
