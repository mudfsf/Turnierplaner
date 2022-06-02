Class {
	#name : 'UserSettings',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Accessing' }
UserSettings >> beforeCreateComponents [
	|thePlayer|
	"User muss noch ermittelt werden"
	thePlayer:=Player firstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.

	self user:thePlayer.
]

{ #category : 'Accessing' }
UserSettings >> createComponents [
	self
		addChild: (Me5Portlet newPrimary
			title:'Einstellungen';
			addChildToBody: (Me5Form new
				addChildToBody: (Me5Row  new
					addChild: (Me5TextField new
						text:'Vorname';
						value: user firstName;
						placeholder:'Vorname';
						addCssClassCol12;
						addCssClassColLg6;
					yourself);
					addChild: (Me5TextField new
						text:'Nachname';
						value: user lastName;
						placeholder: 'Nachname';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
					addChild: (Me5TextField new
						text:'E-Mail';
						value: user email;
						placeholder: 'E-Mail';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
				yourself);
				addChildToBody: (Me5Row new
					addChild: (Me5PasswordField new
							text:'Passwort';
							placeholder: 'Passwort';
							addCssClassColLg6;
							addCssClassCol12;
						yourself);	
					yourself);
				yourself);
				
				addChildToFoot: (Me5Button newPrimary
					text:'Speichern';
					yourself);
				
			yourself);
		yourself
		
		
]

{ #category : 'Accessing' }
UserSettings >> user [

	^user
]

{ #category : 'Accessing' }
UserSettings >> user: aPlayer [

	user := aPlayer
	
]
