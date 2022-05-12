Extension { #name : #RSComposite }

{ #category : #'*Containers-Essentials-Roassal' }
RSComposite class >> ghost: model [

	^ self new
		  model: model;
		  shapes: RSGroup new;
		  extent: 0 @ 0;
		  color: Color transparent;
		  noPaint;
		  propertyAt: #isGhostShape put: true;
		  yourself
]
