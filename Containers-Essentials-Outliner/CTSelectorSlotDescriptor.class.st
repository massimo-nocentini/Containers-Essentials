Class {
	#name : #CTSelectorSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTSelectorSlotDescriptor >> on: anObject [

	^ anObject perform: self selector
]
