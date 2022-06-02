Class {
	#name : 'ManagePlayerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'startUp',
		'firstNameField',
		'lastNameField',
		'emailField',
		'listGrid',
		'outerDataList',
		'data',
		'placeholder'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Initial-Events' }
ManagePlayerView >> beforeCreateComponents [

	| thePlayers player|

	"player := OrderedCollection new.
	player add: (Player new
		firstName: 'A';
		lastName:  'B';
		email: 'A@B.com';
		yourself).
	player add: (Player new
		firstName: 'C';
		lastName:  'D';
		email: 'C@D.com';
		yourself)."
		
	self startUp: StartUp new.	
	"self startUp saveObject: player onPath: 'C:\Test\playersV2.dat'."
	
	thePlayers := self startUp loadAnObjectFromPath: 'C:\Test\playersV2.dat'.
	
	"self placeholder:  (Player new
		firstName: '';
		lastName: '';
		email: '';
		yourself).
	thePlayers add: self placeholder."
	self data: thePlayers.
]

{ #category : 'Initial-Events' }
ManagePlayerView >> createComponents [

	self
		addChild: (Me5FormPortlet new
		addCssClassColMd12;
			addChildToBody: (listGrid := Me5ListGrid new
				addCssClassColMd12;
				height: '60vh';
				dataSourceBlock: [self data];
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'First name';
					getterSelector: #firstName;
					setterSelector: #firstName:;
					enableHeaderSort;
					minWidth: 200;
					maxWidth:  'vw 40';
					yourself);
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'Last name';
					getterSelector: #lastName;
					setterSelector: #lastName:;
					enableHeaderSort;
					enableInitialSort;
					minWidth: 200;
					yourself);
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'Email';
					getterSelector: #email;
					setterSelector: #email:;
					enableHeaderSort;
					minWidth: 200;
					maxWidth:  'vw 40';
					yourself);
				yourself);
			addChildToFootButtonGroup: (Me5Button newSuccess
				icon: Me5I newFasSave; 
				text: 'Save';
				addClickEventSelector: #saveEvent;
				yourself);
			addChildToFootButtonGroup: (Me5Button newWarning
				icon: Me5I newFasUndo;
				text: 'Reset';
				yourself);
			yourself);
		yourself
]

{ #category : 'Initial-Events' }
ManagePlayerView >> createModules [

	super createModules.
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
]

{ #category : 'Accessing' }
ManagePlayerView >> data [

	^data
]

{ #category : 'Accessing' }
ManagePlayerView >> data: aListOfPlayer [

	data := aListOfPlayer
]

{ #category : 'Not categorized' }
ManagePlayerView >> delete: anEvent [

	| thePerson |
	thePerson := anEvent dataGridComponentsHolderCellObject.
	data remove: thePerson.
	self startUp saveObject: self data onPath: 'C:\Test\players.dat'. 
	self listGrid .
	self listGrid resetEditedDataGridCells. "Tell the list grid that all changes were commited."


]

{ #category : 'Accessing' }
ManagePlayerView >> emailField [

	^emailField
]

{ #category : 'Accessing' }
ManagePlayerView >> emailField: anObject [

	emailField := anObject
]

{ #category : 'Accessing' }
ManagePlayerView >> firstNameField [

	^firstNameField
]

{ #category : 'Accessing' }
ManagePlayerView >> firstNameField: anObject [

	firstNameField := anObject
]

{ #category : 'Accessing' }
ManagePlayerView >> lastNameField [

	^lastNameField
]

{ #category : 'Accessing' }
ManagePlayerView >> lastNameField: anObject [

	lastNameField := anObject
]

{ #category : 'Accessing' }
ManagePlayerView >> listGrid [

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayerView >> listGrid: anObject [

	listGrid := anObject
]

{ #category : 'Events' }
ManagePlayerView >> saveEvent [

	| theNumberOfEditedDataGridRows |

	self listGrid validateEditedDataGridCellsForBlock: [ :eachEditedDataGridCell | | theFieldName theValue |
		theFieldName := (self listGrid dataGridColumnDefinitions at: eachEditedDataGridCell field asNumber) title lowercaseFirstCharacter.
		theValue := eachEditedDataGridCell value.
		theValue isEmptyOrNil
		ifTrue: [
			(theFieldName at: 1) isVowel
			ifFalse: [ eachEditedDataGridCell errorText: 'Please enter a ', theFieldName]
			ifTrue: [ eachEditedDataGridCell errorText: 'Please enter an ', theFieldName ].
		].
	].

	self listGrid hasValidationError
		ifTrue: [^self showErrorNotificationWithMessage: 'Validation failed...'].

	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].

	self startUp saveObject: self data onPath: 'C:\Test\playersV2.dat'.
	
	theNumberOfEditedDataGridRows := self listGrid numberOfEditedDataGridRows.
	
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Saved %1 edited row(s)...' bindWith: theNumberOfEditedDataGridRows)
]

{ #category : 'Accessing' }
ManagePlayerView >> startUp [

	^startUp
]

{ #category : 'Accessing' }
ManagePlayerView >> startUp: anObject [

	startUp := anObject
]
