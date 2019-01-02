# xml-semestralka
Semestrálni práce na BI-XML <br/>

Náhled: https://skodamat.github.io/xml-semestralka/html/ <br/>
Prezentace: https://skodamat.github.io/xml-semestralka/prezentace/ <br/>
PDF: https://skodamat.github.io/xml-semestralka/pdf/out.pdf <br/>

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

## Validace pomocí RNG

Validace proběhla v pořádku, pokud vypíše řádku `xml/source.xml validates`

```
xmllint --noout --relaxng xml/schema.rng xml/source.xml
```

Alternativně pomocí JING (úspěšná validace nevypíše nic):
```
java -jar jing.jar xml/schema.rng xml/source.xml
```

## Transformace do html
```
$ cd html
$ java -jar /path/to/saxon9he.jar ../xml/source.xml htmlTransform.xslt
```

## Vytváření epub
Náhled: https://skodamat.github.io/xml-semestralka/epub/
```
$ cd epub
$ java -jar /path/to/saxon9he.jar ../xml/source.xml EpubTransform.xslt
```
Dále postupujte dle návodu na: https://github.com/skodamat/xml-semestralka/blob/master/epub/Vytv%C3%A1%C5%99en%C3%ADEpub-N%C3%A1vod.txt

## Transformace do PDF

Nástroj FOP: https://xmlgraphics.apache.org/fop/download.html
```
fop -xml xml/source.xml -xsl pdf/pdfTransform.xsl -pdf pdf/out.pdf
```
