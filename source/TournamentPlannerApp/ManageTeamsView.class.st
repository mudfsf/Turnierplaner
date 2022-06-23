Class {
	#name : 'ManageTeamsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'teamsRow',
		'modalTextFieldTeamName',
		'modalMultiComboBoxTeamMembers'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
ManageTeamsView >> createComponents [

	"<^iOf Me5Div>"
	"Create the teamsTab where we can see and manage all teams"

	| theTeamMemberDiv theResultDiv theTeamList theCollectionOfTeamMemberCollections thePersons textFieldTeamName multiComboBoxTeamMembers |

	thePersons := OrderedCollection new.
	TournamentPlannerApp collectionOfPlayers data do: [ :eachPerson |
		thePersons add: ('%1 %2' bindWith: eachPerson firstName with: eachPerson lastName)].
	theTeamList := OrderedCollection new.
	theCollectionOfTeamMemberCollections := OrderedCollection new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam |
		| eachPlayerList |
		theTeamList add: eachTeam teamName.
		eachPlayerList := OrderedCollection new.
		eachTeam members do: [ :eachPlayer |
			eachPlayerList add: eachPlayer].
		theCollectionOfTeamMemberCollections add: eachPlayerList].
	self teamsRow: Me5Row new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam | 
		theTeamMemberDiv := Me5Div new.
		eachTeam members do: [ :eachPlayer |
			theTeamMemberDiv addChild: (Me5Div new
			addChild: (Me5P new
			text: eachPlayer asString;
			fontSize: 'large';
			yourself))].
		self teamsRow addChild: (Me5Div new
			padding: 15;
			addCssClassColSm12;
			addCssClassColMd6;
			addCssClassColXl4;
			addChild: (Me5Portlet newPrimary
				title: (eachTeam teamName);
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
					yourself);
				addChildToBody: theTeamMemberDiv;
				yourself);
			yourself)].
	theResultDiv := Me5Div new 
		addChild: (Me5H1 new 
			text: 'Teams';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
		addChild: (Me5Accordion new
			addChild: (Me5AccordionItem new
				icon: Me5I newFasEdit;
				title: 'Team erstellen';
				addChildToContent: (Me5Form new
					addChildToBody: (textFieldTeamName := Me5TextField new
						text: 'Neues Team';
						placeholder: 'Teamname';
						yourself);
					addChildToBody: (multiComboBoxTeamMembers := Me5Select2MultiSelectBox new
						text: 'Teammitglieder';
						objects: thePersons;
						placeholder: 'Personen';
						yourself);
					addChildToActions: (Me5Button newSuccess
						text: 'Speichern';
						icon: Me5I newFasSave;
						addClickEventSelector: #newTeamClicked;
						yourself);
					yourself);
				yourself);
			yourself);
		addChild: self teamsRow;
		yourself.
	self modalTextFieldTeamName: textFieldTeamName.
	self modalMultiComboBoxTeamMembers: multiComboBoxTeamMembers.
	
	self addChild: theResultDiv
	
]

{ #category : 'Accessing' }
ManageTeamsView >> modalMultiComboBoxTeamMembers [

	"<^iOf Me5MultiComboBox>"
	"Answer the modalMultiComboBoxTeamMembers of the receiver"

	^modalMultiComboBoxTeamMembers
]

{ #category : 'Accessing' }
ManageTeamsView >> modalMultiComboBoxTeamMembers: aMe5MultiComboBox [

	"<aMe5MultiComboBox: iOf Me5MultiComboBox, ^self>"
	"Set the modalMultiComboBoxTeamMembers of the receiver"

	modalMultiComboBoxTeamMembers := aMe5MultiComboBox
]

{ #category : 'Accessing' }
ManageTeamsView >> modalTextFieldTeamName [

	"<^iOf Me5TextField>"
	"Answer the modalTextFieldTeamName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Accessing' }
ManageTeamsView >> modalTextFieldTeamName: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the modalTextFieldTeamName of the receiver"

	modalTextFieldTeamName := aMe5TextField
]

{ #category : 'Events' }
ManageTeamsView >> newTeamClicked [
	
	"<^self>"
	"creates new Team"
	
	| theSingleTeamDiv theTeamMembers theTeam theExistingTeam|
	
	theTeamMembers := OrderedCollection new.
	theSingleTeamDiv := Me5Div new.	
	self modalTextFieldTeamName clearErrorText.
	self modalMultiComboBoxTeamMembers clearErrorText.	
	self modalTextFieldTeamName value = ''
		ifTrue: [self modalTextFieldTeamName setErrorText: 'Team hat keinen Namen'].	
	self modalMultiComboBoxTeamMembers selectedObjects size<=0
		ifTrue: [self modalMultiComboBoxTeamMembers setErrorText: 'Team hat zu wenig Mitglieder'].	
	theExistingTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = self modalTextFieldTeamName value] ifNone: [nil].
	theExistingTeam
		ifNil: [
			(self modalMultiComboBoxTeamMembers hasErrorStyle not and: [self modalTextFieldTeamName hasErrorStyle not])
				ifTrue: [
					self modalMultiComboBoxTeamMembers value do: [ :eachValue | 	
						theTeamMembers add: eachValue.
						theSingleTeamDiv addChild: (Me5P new 
							text: eachValue;
							fontSize: 'large';
							yourself)].
					self teamsRow addChild: (Me5Div new
						addChild: (Me5Portlet newPrimary
							title: (self modalTextFieldTeamName value);
							addChildToHeadTools: (Me5A newIconOnlyPrimary
								icon: Me5I newFasTrash;
								addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
								yourself);
							addChildToBody: theSingleTeamDiv;
							yourself);
						padding: 15;
						addCssClassColSm12;
						addCssClassColMd6;
						addCssClassColXl4;
						yourself).				
					theTeam := Team newWithTeamName: (self modalTextFieldTeamName value ) players: theTeamMembers.
					TournamentPlannerApp collectionOfTeams data add: theTeam.					
					TournamentPlannerApp saveCollectionOfTeams: (TournamentPlannerApp collectionOfTeams data).
					self modalTextFieldTeamName value: ''.
					self modalMultiComboBoxTeamMembers deselectAllObjects.
					self showSuccessNotificationWithMessage: ('Team %1 wurde erstellt!' bindWith: theTeam asString)
					]]
		ifNotNil: [self modalTextFieldTeamName setErrorText: ('Das Team exisistiert bereits')]
]

{ #category : 'Events' }
ManageTeamsView >> removeTeam: aMe5DialogEvent [

	"<^self>"
	"removes Team"

	| theDivTeam theTeam |
	
	theDivTeam := aMe5DialogEvent originalEvent component parent parent parent parent parent parent.
	theDivTeam parent removeChild: theDivTeam ifAbsent: [].	
	theTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = theDivTeam children first title] ifNone: [].
	TournamentPlannerApp collectionOfTeams data remove: theTeam ifAbsent: [].
	TournamentPlannerApp saveCollectionOfTeams: TournamentPlannerApp collectionOfTeams data.
	self showSuccessNotificationWithMessage: ('Team %1 gel&ouml;scht' bindWith: theTeam asString)
]

{ #category : 'Accessing' }
ManageTeamsView >> teamsRow [

	"<^iOf Me5Div>"
	"Answer the teamsRow of the receiver"

	^teamsRow
]

{ #category : 'Accessing' }
ManageTeamsView >> teamsRow: aMe5Div [

	"<aMe5Div: iOf Me5Div, ^self>"
	"Set the teamsRow of the receiver"

	teamsRow := aMe5Div
]

{ #category : 'Events' }
ManageTeamsView >> yesNoModalRemoveTeam: aMe5Event [

	"<^self>"

	self showYesNoDialogWithTitle: 'Team l&ouml;schen?' message: '' yesSelector: #removeTeam:
]
