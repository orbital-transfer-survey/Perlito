
. util-perl5/update-ast-perl5.sh
rm tmp.js
perl perlito.pl --verbose -Bjs util-js/perlito.pl
rm perlito-old.js
mv perlito.js perlito-old.js
mv tmp.js perlito.js

