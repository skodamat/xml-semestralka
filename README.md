# xml-semestralka
Semestrálni práce na BI-XML

<b>Martin Scheubrein</b> - Equitorial Guinea, Kyrgyzstan - DTD + RelaxNG <br/>
<b>Matouš Škoda</b> - Brazil, Chile - xslt pro html + css pro html<br/>
<b>Marek Bělohoubek</b> - Israel, Ireland - ePub<br/>
<b>Matyáš Procházka</b> - Montserrat, Oman - parser pro data ze stranek<br/>
<b>Tomáš Pospíšil</b> - Cuba, Egypt - transformace do pdf<br/>

## Validace pomocí DTD

Když příkaz nic nevypíše, validace proběhla v pořádku (vypisuje jen chyby)

```
xmllint --noout --dtdvalid xml/schema.dtd xml/source.xml
```

## Transformace do html
Náhled: https://skodamat.github.io/xml-semestralka/html/
```
$ cd html
$ java -jar /path/to/saxon9he.jar ../xml/source.xml htmlTransform.xslt
```
