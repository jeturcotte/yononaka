#| This class represents a world in which simulations might be run.  
unit class Yononaka::Geometry;

#| The westernmost plot in the world.
has Int $.min-x is required;

#| The easternmost plot in the world.
has Int $.max-x is required;

#| The southernmost plot in the world.
has Int $.min-y is required;

#| The northernmost plot in the world.
has Int $.max-y is required;

#| The world can be toggled to wrap east-to-west, horizontally.
has Bool $.wraps-x = False;

#| The world can be toggled to wrap north-to-south, vertically.
has Bool $.wraps-y = False;

#| Check on the width of the world, noting that 0 is a plot of its own.
method span-x {

  $!max-x - $!min-x + 1 

}

#| Check on the height of the world, noting that 0 is a plot of its own.
method span-y {

  $!max-y - $!min-y + 1

}

#| Check on whether a value is out of bounds while wrapping is or is not enabled
method !out-of-bounds( Int $value, Int $min, Int $max, Bool $wraps ){

  return True if not $wraps and not $min <= $value <= $max

}

#| For any one dimension, make sure that values beyond the bounds wrap around
method !wrap( Int $value, Int $min, Int $extent ) { 

  ( $value - $min ) % $extent + $min

}

#| For a pair of coordinations, normalize their coordinatess if wrapping is allowed
method normalize( $x, $y ) {

  return 
    if self!out-of-bounds( $x, $.min-x, $.max-x, $.wraps-x )
    or self!out-of-bounds( $y, $.min-y, $.max-y, $.wraps-y );

  return
    self!wrap( $x, $.min-x, $.span-x ),
    self!wrap( $y, $.min-y, $.span-y );

}

#| Each cell in this geometry can call .neighbors to retrieve up to eight neighboring cells.
method neighbors( $x, $y ) {

  my @neighbors;

  for -1..1 -> $dx {
    for -1..1 -> $dy {
      next if $dx == 0 && $dy == 0; # skip the center cell itself
      my $nx = $x + $dx;
      my $ny = $y + $dy;
      my ( $nnx, $nny ) = $.normalize( $nx, $ny );
      push @neighbors, [ $nnx, $nny ] if $nnx.defined && $nny.defined;
    }
  }

  # Remove duplicate neighbors that may have resulted from wrapping
  @neighbors.unique( :with( &[eqv] ) )

}

#| Each cell in this geometry can call .orthogonal-neighbors to retrieve up to four neighboring cells in the cardinal directions.
method orthogonal-neighbors( $x, $y ) {

  my @neighbors;

  for [ [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ] -> $offset {
    my ( $dx, $dy ) = @$offset;
    my $nx = $x + $dx;
    my $ny = $y + $dy;
    my ( $nnx, $nny ) = $.normalize( $nx, $ny );
    push @neighbors, [ $nnx, $nny ] if $nnx.defined && $nny.defined;
  }

  # Remove duplicate neighbors that may have resulted from wrapping
  @neighbors.unique( :with( &[eqv] ) )

}

#| Don't return a partially valid world
submethod TWEAK {
  die "Maximum X must not be less than Minimum X" unless $!min-x <= $!max-x;
  die "Maximum Y must not be less than Minimum Y" unless $!min-y <= $!max-y;
}

