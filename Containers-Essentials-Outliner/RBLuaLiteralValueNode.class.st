Class {
	#name : #RBLuaLiteralValueNode,
	#superclass : #RBLiteralValueNode,
	#category : #'Containers-Essentials-Outliner-Presenters'
}

{ #category : #converting }
RBLuaLiteralValueNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	^ TSChunk new
		  language: 'lua';
		  sourceCode: self value;
		  asRSPangoShapeUsingFont: LogicalFont pangoMonospace
]
