Class {
	#name : 'UserSettingsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user',
		'playerCombobox'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
UserSettingsView >> createComponents [

	"<^self>"
	"Sends the userSettings Tab to the receiver"

	(TournamentPlannerApp loggedInUser isNil)
		ifTrue: [self user: TournamentPlannerApp collectionOfPlayers data first]
		ifFalse: [self user: TournamentPlannerApp loggedInUser].
			
	self playerCombobox: (Me5ComboBox new
					text: 'Benutzer ausw&auml;len';			
					objects: (TournamentPlannerApp collectionOfPlayers data collect: [ :eachPlayer |
						eachPlayer asString]);
					selectedObject: self user asString;
					addChangeEventSelector: #userSelectedEvent eventReceiver: self;
					addCssClassColLg6;
					addCssClassCol12;
					yourself).
			
	self addChild: (Me5Div new
		addChild: (Me5H1 new 
			text: 'Einstellungen';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
			addChild: (Me5Form new
				addChildToBody: (Me5Row  new
					addChild: (Me5TextField new
						text: 'Vorname';
						value: user firstName;
						placeholder: 'Vorname';
						addCssClassCol12;
						addCssClassColLg6;
						yourself);
					addChild: (Me5TextField new
						text: 'Nachname';
						value: user lastName;
						placeholder: 'Nachname';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: (Me5TextField new
						text: 'E-Mail';
						value: user email;
						placeholder: 'E-Mail';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: (Me5PasswordField new
						text: 'Passwort';
						placeholder: 'Passwort';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: self playerCombobox;
					yourself);
				addChildToRow: (Me5Button newSuccess
					text: 'Speichern';
					icon: Me5I newFasSave;
					addClickEventSelector: #savePlayer eventReceiver: self;
					yourself);
				yourself);
			yourself)
]

{ #category : 'Accessing' }
UserSettingsView >> playerCombobox [

	"<^iOf Me5Combobox>"
	"Answer the playerCombobox of the receiver"

	^playerCombobox
]

{ #category : 'Accessing' }
UserSettingsView >> playerCombobox: aMe5Combobox [

	"<aMe5Combobox: iOf Me5Combobox, ^self>"
	"Set the playerCombobox of the receiver"

	playerCombobox := aMe5Combobox
]

{ #category : 'Events' }
UserSettingsView >> savePlayer [

	"<^self>"
	"Change the attributes of the logged in player"

	^self error: 'Message not implemented'
]

{ #category : 'Accessing' }
UserSettingsView >> user [

	"<^iOf Player>"
	"Answer the user of the receiver"

	^user
]

{ #category : 'Accessing' }
UserSettingsView >> user: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the user of the receiver"

	user := aPlayer
]

{ #category : 'Events' }
UserSettingsView >> userSelectedEvent [

	"^self"
	"Saves the selected player into the logged-in User. This is only used before the log-in is implemented"
	
	| theUsername thePlayer|
	
	theUsername := self playerCombobox selectedObject.
	
	thePlayer := TournamentPlannerApp collectionOfPlayers data at: (TournamentPlannerApp collectionOfPlayers data findFirst: [ :eachPlayer |
		eachPlayer asString = theUsername]) ifAbsent: [ self showErrorNotificationWithMessage: 'Ein Fehler ist aufgetreten, bitte die Seite neuladen'. ^self].

	self user: thePlayer.
	TournamentPlannerApp loggedInUser: thePlayer.
	
	self showSuccessNotificationWithMessage: ('Eingeloggter user: %1' bindWith: thePlayer asString).
	self reloadViewBySourceView: self
]
