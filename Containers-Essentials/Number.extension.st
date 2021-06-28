Extension { #name : #Number }

{ #category : #'*Containers-Essentials' }
Number >> decrement [
	^ self - 1
]

{ #category : #'*Containers-Essentials' }
Number >> density: aRandom [

	^ aRandom densityOfNumber: self
]

{ #category : #'*Containers-Essentials' }
Number >> increment [
	^ self + 1
]
