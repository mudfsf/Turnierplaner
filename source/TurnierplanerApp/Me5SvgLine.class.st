Class {
	#name : 'Me5SvgLine',
	#superclass : 'Me5BaseComponent',
	#instVars : [
		'x1',
		'x2',
		'y1',
		'y2',
		'strokeWidth',
		'stroke',
		'svgWidth',
		'svgHeight',
		'svgTop',
		'svgLeft'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
Me5SvgLine >> htmlElementClass [

	^ClwHtmlElementDiv
	
]

{ #category : 'Not categorized' }
Me5SvgLine >> setAdditionalAttributesOfHtmlElement: aClwHtmlBaseElement [

| theSvgElement |

	super setAdditionalAttributesOfHtmlElement: aClwHtmlBaseElement.
	theSvgElement := (ClwHtmlSvg new 
		attributeAt: 'style' put: ('position: absolute; left: %1; top: %2' bindWith: self svgLeft with: self svgTop);
		width: self svgWidth;
		height: self svgHeight;
		yourself). 

	theSvgElement addLine
		x1: self x1;
		x2: self x2;
		y1: self y1;
		y2: self y2;
		stroke: self stroke;
		strokeWidth: self strokeWidth;
		yourself.

	aClwHtmlBaseElement 
		attributeAt: 'style' put: 'text-align: center';
		text: (theSvgElement asXmlString);
		yourself.
]

{ #category : 'Accessing' }
Me5SvgLine >> stroke [

	"<^hOf Number>"
	"Answer the stroke of the receiver"

	^stroke
]

{ #category : 'Accessing' }
Me5SvgLine >> stroke: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the stroke of the receiver"

	stroke := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> strokeWidth [

	"<^hOf Number>"
	"Answer the strokeWidth of the receiver"

	^strokeWidth
]

{ #category : 'Accessing' }
Me5SvgLine >> strokeWidth: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the strokeWidth of the receiver"

	strokeWidth := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> svgHeight [

	"<^hOf Number>"
	"Answer the svgHeight of the receiver"

	^svgHeight
]

{ #category : 'Accessing' }
Me5SvgLine >> svgHeight: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the svgHeight of the receiver"

	svgHeight := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> svgLeft [

	"<^hOf Number>"
	"Answer the svgLeft of the receiver"

	^svgLeft
]

{ #category : 'Accessing' }
Me5SvgLine >> svgLeft: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the svgLeft of the receiver"

	svgLeft := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> svgTop [

	"<^hOf Number>"
	"Answer the svgTop of the receiver"

	^svgTop
]

{ #category : 'Accessing' }
Me5SvgLine >> svgTop: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the svgTop of the receiver"

	svgTop := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> svgWidth [

	"<^hOf Number>"
	"Answer the svgWidth of the receiver"

	^svgWidth
]

{ #category : 'Accessing' }
Me5SvgLine >> svgWidth: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the svgWidth of the receiver"

	svgWidth := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> x1 [

	"<^hOf Number>"
	"Answer the x1 of the receiver"

	^x1
]

{ #category : 'Accessing' }
Me5SvgLine >> x1: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the x1 of the receiver"

	x1 := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> x2 [

	"<^hOf Number>"
	"Answer the x2 of the receiver"

	^x2
]

{ #category : 'Accessing' }
Me5SvgLine >> x2: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the x2 of the receiver"

	x2 := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> y1 [

	"<^hOf Number>"
	"Answer the y1 of the receiver"

	^y1
]

{ #category : 'Accessing' }
Me5SvgLine >> y1: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the y1 of the receiver"

	y1 := aNumber
]

{ #category : 'Accessing' }
Me5SvgLine >> y2 [

	"<^hOf Number>"
	"Answer the y2 of the receiver"

	^y2
]

{ #category : 'Accessing' }
Me5SvgLine >> y2: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the y2 of the receiver"

	y2 := aNumber
]
