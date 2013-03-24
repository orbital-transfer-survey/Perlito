use strict;
use warnings;

package Perlito5::X64::Register;

sub new {
    my $class = shift;
    bless {@_}, $class;
}


package Perlito5::X64::Assembler;

my @buffer;
my @hex_char = qw( 0 1 2 3 4 5 6 7 8 9 A B C D E F );

#--- registers

my $r_rax = Perlito5::X64::Register->new( code => 0  );
my $r_rcx = Perlito5::X64::Register->new( code => 1  );
my $r_rdx = Perlito5::X64::Register->new( code => 2  );
my $r_rbx = Perlito5::X64::Register->new( code => 3  );
my $r_rsp = Perlito5::X64::Register->new( code => 4  );
my $r_rbp = Perlito5::X64::Register->new( code => 5  );
my $r_rsi = Perlito5::X64::Register->new( code => 6  );
my $r_rdi = Perlito5::X64::Register->new( code => 7  );
my $r_r8  = Perlito5::X64::Register->new( code => 8  );
my $r_r9  = Perlito5::X64::Register->new( code => 9  );
my $r_r10 = Perlito5::X64::Register->new( code => 10 );
my $r_r11 = Perlito5::X64::Register->new( code => 11 );
my $r_r12 = Perlito5::X64::Register->new( code => 12 );
my $r_r13 = Perlito5::X64::Register->new( code => 13 );
my $r_r14 = Perlito5::X64::Register->new( code => 14 );
my $r_r15 = Perlito5::X64::Register->new( code => 15 );

sub rax { $r_rax } 
sub rcx { $r_rcx }
sub rdx { $r_rdx }
sub rbx { $r_rbx }
sub rsp { $r_rsp }
sub rbp { $r_rbp }
sub rsi { $r_rsi }
sub rdi { $r_rdi }
sub r8  { $r_r8  }
sub r9  { $r_r9  }
sub r10 { $r_r10 }
sub r11 { $r_r11 }
sub r12 { $r_r12 }
sub r13 { $r_r13 }
sub r14 { $r_r14 }
sub r15 { $r_r15 }

#--- general

sub new {
    my $class = shift;
    @buffer = ();
    bless {@_}, $class;
}

sub to_hex {
    return join(' ',
               map( $hex_char[int($_ / 16)] . $hex_char[$_ % 16], @buffer ) );
}

sub emit {
    push @buffer, $_[0];
}

sub is_register {
    ref($_[0]) eq 'Perlito5::X64::Register'
}

sub is_zero { 
    return $_[0] == 0;
}

sub is_int8 {
    return -128 <= $_[0] && $_[0] < 128;
}

sub is_int16 {
    return -32768 <= $_[0] && $_[0] < 32768;
}

sub is_uint8 {
    return 0 <= $_[0] && $_[0] < 256;
}

sub is_uint16 {
    return 0 <= $_[0] && $_[0] < 65536;
}


#--- instructions

sub nop {
    emit(0x90);
}

sub ret {
    my ( $imm16 ) = @_;
    if ( !$imm16 ) {
        emit(0xC3);
    }
    else {
        emit(0xC2);
        emit( $imm16 & 0xFF );
        emit( ( $imm16 >> 8 ) & 0xFF );
    }
}

1;

__END__

=pod

=head1 Perlito5::X64::Assembler

The Perlito5 x64 backend

=head1 Synopsis

    use Perlito5::X64::Assembler;

    package Perlito5::X64::Assembler;
    ret();
    say to_hex();   # C3

=head1 References

- V8 Javascript Compiler

    src/x64/assembler-x64.cc

=cut


