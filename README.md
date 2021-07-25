# iOS-Basics - Semesterprojekt

### Aufgabenstellung:
Erstellen Sie eine App zur Darstellung von CityBike-Stationen in Wien auf einer Karte.
Die App sollte mit einem Ausschnitt in Wien starten. Die eigene Position muss nicht unbedingt angezeigt werden.

Echtzeit-Informationen zu den CityBike-Stationen finden Sie unter folgendem Link: [Citybike-Stationen-Wien](https://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:CITYBIKEOGD&srsName=EPSG:4326&outputFormat=json)

### Konzept und Implementierung:
Umsetzung erfolgte mittels MapKit-API. Erstellung benutzerdefinierter Annotation-Views in Form von Fahrrad-Images.<br/>
Unterschiedliche Farben der Annotationen, abhängig vom Bezirk.<br/>
Annotationen mit Maps-App-Button, Stationsname und -koordinaten als Zusatzinformationen.<br/>
Maps-App-Button ermöglicht Navigation vom aktuellen Standort zu gewählter Citybike-Station.<br/>
Button mit der Funktion zum Umschalten der Kartenansicht (Standardkarte oder Satellit).<br/>
