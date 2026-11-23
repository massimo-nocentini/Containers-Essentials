"
I am a comment node that comes from no source code: `withString:` makes me from a string, which becomes a comment between double quotes. My `sourceCode` is my own text. `CTNotebookKeyedValuedOrderedCollection` makes me for the title of a notebook, which is shown as its other comments.
"
Class {
	#name : 'CTDFSRBComment',
	#superclass : 'OCCommentNode',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'instance creation' }
CTDFSRBComment class >> withString: commentString [

	^ self with: '"' , commentString , '"' at: 1
]

{ #category : 'accessing' }
CTDFSRBComment >> sourceCode [

	^ self contents
]
