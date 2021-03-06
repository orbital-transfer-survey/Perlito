
package JavaRDD::String { import => "org.apache.spark.api.java.JavaRDD<String>" }

package JavaSparkContext { import => "org.apache.spark.api.java.JavaSparkContext" }

package SparkSession { import => "org.apache.spark.sql.SparkSession" }

package Integer { import => "java.lang.Integer" }

package List { import => "java.util.ArrayList<String>" }

use strict;
use warnings;
use Java;

my SparkSession $spark =
  SparkSession
  ->builder()
  ->appName("JavaSparkPi")
  ->config( "spark.master", "local" )
  # ->config( "spark.jars", "./perlito5.jar,./spark-2.4.4-bin-hadoop2.7/jars/*" )
  ->getOrCreate();

my JavaSparkContext $jsc = JavaSparkContext->new( $spark->sparkContext() );

my Integer $slices = $ARGV[0] // 2;
my $n = 100000 * $slices;

print "slices: $slices; n: $n\n";

my List $list = List->new();
for ( 0 .. $n - 1 ) {
    $list->add("$_");
}

my JavaRDD::String $dataSet = $jsc->parallelize( $list, $slices );

my $count;

# TODO
my $map = sub {
    my $x = rand(2) - 1;
    my $y = rand(2) - 1;
    return ( $x * $x + $y * $y <= 1 ) ? 1 : 0;
};
my $reduce = sub { $_[0] + $_[1] };

$count = $dataSet->map(

    Java::inline q(
        arg -> {
            // TODO use $map
            return arg;
        }
    )

  )->reduce(

    Java::inline q(
        (arg1, arg2) -> {
            // TODO use $reduce
            return new PlString(arg1).add(new PlString(arg2)).toString();
        }
    )

  );

print "Pi is roughly ", 4.0 * $count / $n, "\n";

$spark->stop();

