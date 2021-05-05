Extension { #name : #Number }

{ #category : #'*Kernel-Extensions' }
Number >> decrement [
	^ self - 1
]

{ #category : #'*Kernel-Extensions' }
Number >> double [

	^ self * 2
]

{ #category : #'*Kernel-Extensions' }
Number >> increment [
	^ self + 1
]

{ #category : #'*Kernel-Extensions' }
Number >> to: end splitAt: split beforeDo: bBlock afterDo: aBlock [
	1 to: split do: bBlock.
	split + 1 to: end do: aBlock
]
