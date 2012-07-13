#!/bin/bash                                                                                                                    

AUTOCLICK=/opt/autoclickchem/bin/autoclickchem.py

# locate babel
if [ -f /etc/profile.d/rocks-openbabel.sh ] ; then 
	 . /etc/profile.d/rocks-openbabel.sh
fi

BABEL=`which babel 2>/dev/null`

if [ "$BABEL" = "" ] ; then
    echo "ERROR: babel not found. Please check your babel installation."
    exit 0
fi

echo "Wrapper sees arguments $@"

# assign each of the commandline arguments to a variable
while [ "$1" != "" ]; do
    case $1 in
        -reactants1 )           shift
                                reactants1=$1
                                ;;
        -reactants2 )           shift
                                reactants2=$1
                                ;;
        -config )               shift
                                config=$1
				;;
        * )                     echo "Invalid argument in $@"
	exit 1
    esac
    shift
done

# throw an error if a required argument is not specified
if test -z "$reactants1" || test -z "$reactants2"; then
  echo "ERROR: Missing one or more reactant directories"
  exit 1
fi

# store the filename extension in a variable. this is to ensure that it is a zip file.
r1ext=`echo $reactants1 | awk -F'.' '{print $NF}'`
r2ext=`echo $reactants2 | awk -F'.' '{print $NF}'`

# check to make sure the uploaded file is in an appropriate format
if test "$r1ext" != "zip" && test "$r1ext" != "pdb" && test "$r1ext" != "ent" && test "$r1ext" != "ml2" && test "$r1ext" != "mol2" && test "$r1ext" != "sy2" && test "$r1ext" != "mdl" && test "$r1ext" != "mol" && test "$r1ext" != "sd" && test "$r1ext" != "sdf" && test "$r1ext" != "xyz" && test "$r1ext" != "ZIP" && test "$r1ext" != "PDB" && test "$r1ext" != "ENT" && test "$r1ext" != "ML2" && test "$r1ext" != "MOL2" && test "$r1ext" != "SY2" && test "$r1ext" != "MDL" && test "$r1ext" != "MOL" && test "$r1ext" != "SD" && test "$r1ext" != "SDF" && test "$r1ext" != "XYZ"; then
  echo "ERROR: uploaded file must be in zip, pdb, ent, ml2, mol2, sy2, mdl, mol, sd, sdf, or xyz format"
  exit 1
fi

if test "$r2ext" != "zip" && test "$r2ext" != "pdb" && test "$r2ext" != "ent" && test "$r2ext" != "ml2" && test "$r2ext" != "mol2" && test "$r2ext" != "sy2" && test "$r2ext" != "mdl" && test "$r2ext" != "mol" && test "$r2ext" != "sd" && test "$r2ext" != "sdf" && test "$r2ext" != "xyz" && test "$r2ext" != "ZIP" && test "$r2ext" != "PDB" && test "$r2ext" != "ENT" && test "$r2ext" != "ML2" && test "$r2ext" != "MOL2" && test "$r2ext" != "SY2" && test "$r2ext" != "MDL" && test "$r2ext" != "MOL" && test "$r2ext" != "SD" && test "$r2ext" != "SDF" && test "$r2ext" != "XYZ"; then
  echo "ERROR: uploaded file must be in zip, pdb, ent, ml2, mol2, sy2, mdl, mol, sd, sdf, or xyz format"
  exit 1
fi

# all periods in the file name need to be replaced with underscores, except that of the extension
# all the extensions need to be lower case, so go through and rename if necessary
r1notext=`echo $reactants1 | sed "s/.$r1ext$//g" | sed "s/\./_/g"`
reactants1_rename=`echo $r1notext $r1ext | awk '{print $1 "." tolower($2)}'`

r2notext=`echo $reactants2 | sed "s/.$r2ext$//g" | sed "s/\./_/g"`
reactants2_rename=`echo $r2notext $r2ext | awk '{print $1 "." tolower($2)}'`

r1dir=reactant1_dir
r2dir=reactant2_dir

mkdir $r1dir $r2dir

mv $reactants1 $r1dir/$reactants1_rename
mv $reactants2 $r2dir/$reactants2_rename

# now uncompress any zip files
cd $r1dir
unzip -j *.zip
cd ../$r2dir
unzip -j *.zip

# now delete any zip files
cd ../
rm ./$r1dir/*.zip
rm ./$r2dir/*.zip

# sometimes multiple filename extensions correspond to the same type of file, so rename to simplify
cd $r1dir
ls *.ent | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "pdb"}' | bash
ls *.ml2 | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol2"}' | bash
ls *.sy2 | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol2"}' | bash
ls *.mdl | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol"}' | bash
ls *.sd | awk '{print "mv " $1 " " substr($1,0,length($1)-2) "mol"}' | bash
ls *.sdf | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol"}' | bash

cd ../$r2dir
ls *.ent | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "pdb"}' | bash
ls *.ml2 | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol2"}' | bash
ls *.sy2 | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol2"}' | bash
ls *.mdl | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol"}' | bash
ls *.sd | awk '{print "mv " $1 " " substr($1,0,length($1)-2) "mol"}' | bash
ls *.sdf | awk '{print "mv " $1 " " substr($1,0,length($1)-3) "mol"}' | bash

# now use babel to convert all files into PDB format. This will also split files containing multiple structures into separate files.
cd ../$r1dir
ls | grep -v "^files$" > files
for file in `cat files`
do
  exten=`echo $file | awk -F'.' '{print $NF}'`
  notexten=`echo $file | sed "s/.$exten$//g"`
  $BABEL -i$exten $file -opdb $notexten.pdb -m
done
cd ../$r2dir
ls | grep -v "^files$" > files
for file in `cat files`
do
  exten=`echo $file | awk -F'.' '{print $NF}'`
  notexten=`echo $file | sed "s/.$exten$//g"`
  $BABEL -i$exten $file -opdb $notexten.pdb -m
done

# now go through and delete all the files that are not babel-converted pdb files
cd ../$r1dir
cat files | awk '{print "rm " $1}' | csh
ls | grep -v "\.pdb$" | awk '{print "rm " $1}'
rm files

cd ../$r2dir
cat files | awk '{print "rm " $1}' | csh
ls | grep -v "\.pdb$" | awk '{print "rm " $1}'
rm files

# now, strip some PDB tags from the BABEL-generated files
cd ../$r1dir
ls | awk '{print "cat " $1 " | sed \"s/HETATM/ATOM  /g\" | grep \"^ATOM \" > t; mv t " $1}'

cd ../$r2dir
ls | awk '{print "cat " $1 " | sed \"s/HETATM/ATOM  /g\" | grep \"^ATOM \" > t; mv t " $1}'

cd ../

CMD="python $AUTOCLICK -input_file $config -reactants1 $r1dir -reactants2 $r2dir -output_dir ./output/"
echo "Going to execute command: "
echo "$CMD"
$CMD
