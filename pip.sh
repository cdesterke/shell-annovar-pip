#!/bin/bash
##script to pip VCF dans ANNOVAR avec conversion et annotation multiple
##Christophe Desterke_25oct2014
## sh pipnov2014.sh example.vcf (entrer le nom du VCF input en parametre de commande)

nom_fichier=$(echo $1 | sed -re 's/(.*).vcf/\1/')


UPTIME1=`uptime`

##conversion du VCF en AVinput ANNOVAR
perl convert2annovar.pl -format vcf4  $1 -outfile outav

UPTIME2=`uptime`

perl table_annovar.pl outav humandb/ -buildver hg19 -out refgene -remove -protocol refGene,ensGene,cytoBand,genomicSuperDups,popfreq_all,esp6500si_all,1000g2012apr_all,snp132,snp138,ljb26_all,gwasCatalog,targetScanS,cosmic70,caddgt20,nci60,clinvar_20140929 -operation g,g,r,r,f,f,f,f,f,f,r,r,f,f,f,f -nastring . -csvout


mv refgene.hg19_multianno.csv $(echo refgene.hg19_multianno.csv | sed "s/\./".$nom_fichier"\./")


rm outav
UPTIME3=`uptime`

##log

echo "---------------------------------"
echo "log of the pipeline in ANNOVAR"
echo "analyse du ficher = $nom_fichier"
echo "--------------------"
cal
echo "--------------------"
echo "START"
echo "Uptime = $UPTIME1"
echo "-------------"
echo "convertion ok"
echo "Uptime = $UPTIME2"
echo "------------"
echo "annotation ok"
echo "Uptime = $UPTIME3"
echo "------------"

exit 0
