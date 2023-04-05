Class {
	#name : #CTNotebookKeyedValuedOrderedCollection,
	#superclass : #CTKeyedValuedOrderedCollection,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #visiting }
CTNotebookKeyedValuedOrderedCollection >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTNotebookKeyedValuedOrderedCollection: self
]
