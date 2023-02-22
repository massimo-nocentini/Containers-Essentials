Extension { #name : #Collection }

{ #category : #'*Containers-Essentials-Outliner' }
Collection >> asCollectionKeyBlock: keyBlock valueBlock: valueBlock [

	^ CTKeyedValuedOrderedCollection new
		  collection: self;
		  keyBlock: keyBlock;
		  valueBlock: valueBlock;
		  yourself
]
