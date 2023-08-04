Class {
	#name : #CTDFSRBComment,
	#superclass : #RBComment,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #'instance creation' }
CTDFSRBComment class >> withString: commentString [

	^ self with: '"' , commentString , '"' at: 1
]

{ #category : #accessing }
CTDFSRBComment >> sourceCode [

	^ self contents
]
