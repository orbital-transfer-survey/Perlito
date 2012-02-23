# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
use v5;
use Perlito5::AST;
package Perl6;
(do {
    sub tab {
        ((my  $level) = shift());
        ((chr(9)) x $level)
    };
    ((my  %safe_char) = ((chr(36) => 1), (chr(37) => 1), (chr(64) => 1), (chr(38) => 1), ('_' => 1), (',' => 1), ('.' => 1), (':' => 1), (chr(59) => 1), ('-' => 1), ('+' => 1), ('*' => 1), (' ' => 1), ('(' => 1), (')' => 1), ('<' => 1), (chr(61) => 1), ('>' => 1), ('[' => 1), (']' => 1), (chr(123) => 1), (chr(124) => 1), (chr(125) => 1)));
    sub escape_string {
        ((my  $s) = shift());
        (my  @out);
        ((my  $tmp) = '');
        if (($s eq '')) {
            return ((chr(39) . chr(39)))
        };
        for my $i ((0 .. (length($s) - 1))) {
            ((my  $c) = substr($s, $i, 1));
            if (((((((($c ge 'a') && ($c le 'z'))) || ((($c ge 'A') && ($c le 'Z')))) || ((($c ge '0') && ($c le '9')))) || exists($safe_char{$c})))) {
                ($tmp = ($tmp . $c))
            }
            else {
                if (($tmp ne '')) {
                    push(@out, (chr(39) . $tmp . chr(39)) )
                };
                push(@out, ('chr(' . ord($c) . (')')) );
                ($tmp = '')
            }
        };
        if (($tmp ne '')) {
            push(@out, (chr(39) . $tmp . chr(39)) )
        };
        return (join(' ' . chr(126) . ' ', @out))
    };
    sub to_str {
        ((my  $cond) = shift());
        if (($cond->isa('Val::Buf'))) {
            return ($cond->emit_perl6())
        }
        else {
            return (('(' . $cond->emit_perl6() . ')'))
        }
    };
    sub to_num {
        ((my  $cond) = shift());
        if ((($cond->isa('Val::Int') || $cond->isa('Val::Num')))) {
            return ($cond->emit_perl6())
        }
        else {
            return (('(' . $cond->emit_perl6() . ')'))
        }
    };
    sub to_bool {
        ((my  $cond) = shift());
        if ((((((($cond->isa('Val::Int')) || ($cond->isa('Val::Num'))) || (($cond->isa('Apply') && ($cond->code() eq 'infix:<' . chr(124) . chr(124) . '>')))) || (($cond->isa('Apply') && ($cond->code() eq 'infix:<' . chr(38) . chr(38) . '>')))) || (($cond->isa('Apply') && ($cond->code() eq 'prefix:<' . chr(33) . '>')))))) {
            return ($cond->emit_perl6())
        }
        else {
            return (('(' . $cond->emit_perl6() . ')'))
        }
    }
});
package Perlito5::Perl6::LexicalBlock;
(do {
    sub new {
        ((my  $class) = shift());
        bless((do {
    (my  %a);
    (do {
        ((my  $_i) = 0);
        ((my  @_a) = @_);
        for ( ; (($_i < scalar(@_a)));  ) {
            ($a{$_a[$_i]} = $_a[($_i + 1)]);
            ($_i = ($_i + 2))
        }
    });
    \%a
}), $class)
    };
    sub block {
        $_[0]->{'block'}
    };
    sub needs_return {
        $_[0]->{'needs_return'}
    };
    sub top_level {
        $_[0]->{'top_level'}
    };
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if (($self->{('top_level')})) {
            ((my  $block) = Perlito5::Perl6::LexicalBlock->new(('block' => $self->block()), ('needs_return' => $self->needs_return()), ('top_level' => 0)));
            return (($block->emit_perl6_indented(($level + 1)) . chr(59) . (chr(10))))
        };
        (my  @block);
        for ((@{$self->{('block')}})) {
            if ((defined($_))) {
                push(@block, $_ )
            }
        };
        if ((!(@block))) {
            return ((Perl6::tab($level) . 'null' . chr(59)))
        };
        (my  @str);
        for my $decl (@block) {
            if ((($decl->isa('Decl') && ($decl->decl() eq 'my')))) {
                push(@str, (Perl6::tab($level) . $decl->emit_perl6_init()) )
            };
            if ((($decl->isa('Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                ((my  $var) = $decl->arguments()->[0]);
                if ((($var->isa('Decl') && ($var->decl() eq 'my')))) {
                    push(@str, (Perl6::tab($level) . $var->emit_perl6_init()) )
                }
            }
        };
        for my $decl (@block) {
            if ((!((($decl->isa('Decl') && ($decl->decl() eq 'my')))))) {
                push(@str, ($decl->emit_perl6_indented($level) . chr(59)) )
            }
        };
        return ((join((chr(10)), @str) . chr(59)))
    }
});
package CompUnit;
(do {
    sub emit_perl6 {
        ((my  $self) = $_[0]);
        $self->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = $_[0]);
        ((my  $level) = $_[1]);
        (my  @body);
        ((my  $i) = 0);
        for ( ; (($i <= scalar(@{$self->{('body')}})));  ) {
            ((my  $stmt) = $self->{('body')}->[$i]);
            if ((((ref($stmt) eq 'Apply') && ($stmt->code() eq 'package')))) {
                ((my  $name) = $stmt->namespace());
                (my  @stmts);
                ($i)++;
                for ( ; ((($i <= scalar(@{$self->{('body')}})) && !((((ref($self->{('body')}->[$i]) eq 'Apply') && ($self->{('body')}->[$i]->code() eq 'package'))))));  ) {
                    push(@stmts, $self->{('body')}->[$i] );
                    ($i)++
                };
                push(@body, CompUnit->new(('name' => $name), ('body' => \@stmts)) )
            }
            else {
                if (defined($stmt)) {
                    push(@body, $stmt )
                };
                ($i)++
            }
        };
        ((my  $class_name) = $self->{('name')});
        ((my  $str) = ('package ' . $class_name . chr(59) . (chr(10))));
        for my $decl (@body) {
            if ((($decl->isa('Decl') && (($decl->decl() eq 'my'))))) {
                ($str = ($str . '  ' . $decl->emit_perl6_init()))
            };
            if ((($decl->isa('Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                ((my  $var) = $decl->arguments()->[0]);
                if ((($var->isa('Decl') && ($var->decl() eq 'my')))) {
                    ($str = ($str . '  ' . $var->emit_perl6_init()))
                }
            }
        };
        for my $decl (@body) {
            if (($decl->isa('Sub'))) {
                ($str = ($str . ($decl)->emit_perl6_indented(($level + 1)) . (chr(59) . chr(10))))
            }
        };
        for my $decl (@body) {
            if ((((defined($decl) && (!((($decl->isa('Decl') && ($decl->decl() eq 'my')))))) && (!(($decl->isa('Sub'))))))) {
                ($str = ($str . ($decl)->emit_perl6_indented(($level + 1)) . (chr(59) . chr(10))))
            }
        };
        ($str . (chr(10)))
    };
    sub emit_perl6_program {
        ((my  $comp_units) = shift());
        ((my  $str) = '');
        for my $comp_unit (@{$comp_units}) {
            ($str = ($str . $comp_unit->emit_perl6() . (chr(10))))
        };
        return ($str)
    }
});
package Val::Int;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Perl6::tab($level) . $self->{('int')})
    }
});
package Val::Num;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Perl6::tab($level) . $self->{('num')})
    }
});
package Val::Buf;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Perl6::tab($level) . Perl6::escape_string($self->{('buf')}))
    }
});
package Lit::Block;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $sig) = 'v__');
        if (($self->{('sig')})) {
            ($sig = $self->{('sig')}->emit_perl6_indented(($level + 1)))
        };
        return ((Perl6::tab($level) . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . (Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('stmts')}), ('needs_return' => 1)))->emit_perl6_indented(($level + 1)) . (chr(10)) . Perl6::tab($level) . chr(125) . ')'))
    }
});
package Lit::Array;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $ast) = $self->expand_interpolation());
        return ($ast->emit_perl6_indented($level))
    }
});
package Lit::Hash;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $ast) = $self->expand_interpolation());
        return ($ast->emit_perl6_indented($level))
    }
});
package Index;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Var->new(('sigil' => chr(64)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_perl6_indented($level) . '[' . $self->{('index_exp')}->emit_perl6() . ']'))
        };
        (Perl6::tab($level) . $self->{('obj')}->emit_perl6() . '[' . $self->{('index_exp')}->emit_perl6() . ']')
    }
});
package Lookup;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Var->new(('sigil' => chr(37)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_perl6_indented($level) . '[' . $self->{('index_exp')}->emit_perl6() . ']'))
        };
        return (($self->{('obj')}->emit_perl6_indented($level) . '._hash_[' . $self->{('index_exp')}->emit_perl6() . ']'))
    }
});
package Var;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('sigil')} eq '*'))) {
            ((my  $ns) = 'v__NAMESPACE');
            if (($self->{('namespace')})) {
                ($ns = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . ']'))
            };
            return (($ns . '[' . chr(34) . $self->{('name')} . chr(34) . ']'))
        };
        ((my  $ns) = '');
        if (($self->{('namespace')})) {
            ($ns = ($self->{('namespace')} . '::'))
        };
        ($ns . $self->{('sigil')} . $self->{('name')})
    };
    sub plain_name {
        ((my  $self) = shift());
        if (($self->namespace())) {
            return (($self->namespace() . '.' . $self->name()))
        };
        return ($self->name())
    }
});
package Proto;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Perl6::tab($level) . 'CLASS[' . chr(34) . $self->{('name')} . chr(34) . ']')
    }
});
package Call;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $invocant) = $self->{('invocant')}->emit_perl6());
        ((my  $meth) = $self->{('method')});
        if ((($meth eq 'postcircumfix:<[ ]>'))) {
            return ((Perl6::tab($level) . $invocant . '[' . $self->{('arguments')}->emit_perl6() . ']'))
        };
        if ((($meth eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
            return ((Perl6::tab($level) . $invocant . '._hash_[' . $self->{('arguments')}->emit_perl6() . ']'))
        };
        if ((($meth eq 'postcircumfix:<( )>'))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_perl6() )
            };
            return ((Perl6::tab($level) . '(' . $invocant . ')(' . join(',', @args) . ')'))
        };
        ((my  @args) = ($invocant));
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_perl6() )
        };
        return ((Perl6::tab($level) . $invocant . '._class_.' . $meth . '(' . join(',', @args) . ')'))
    }
});
package Apply;
(do {
    ((my  %op_infix_js) = (('infix:<->' => ' - '), ('infix:<*>' => ' * '), ('infix:<x>' => ' x '), ('infix:<+>' => ' + '), ('infix:<.>' => ' ' . chr(126) . ' '), ('infix:<' . chr(47) . '>' => ' ' . chr(47) . ' '), ('infix:<>>' => ' > '), ('infix:<<>' => ' < '), ('infix:<>' . chr(61) . '>' => ' >' . chr(61) . ' '), ('infix:<<' . chr(61) . '>' => ' <' . chr(61) . ' '), ('infix:<eq>' => ' eq '), ('infix:<ne>' => ' ne '), ('infix:<le>' => ' le '), ('infix:<ge>' => ' ge '), ('infix:<' . chr(61) . chr(61) . '>' => ' ' . chr(61) . chr(61) . ' '), ('infix:<' . chr(33) . chr(61) . '>' => ' ' . chr(33) . chr(61) . ' '), ('infix:<..>' => ' .. '), ('infix:<' . chr(38) . chr(38) . '>' => ' ' . chr(38) . chr(38) . ' '), ('infix:<' . chr(124) . chr(124) . '>' => ' ' . chr(124) . chr(124) . ' '), ('infix:<and>' => ' and '), ('infix:<or>' => ' or '), ('infix:<' . chr(47) . chr(47) . '>' => ' ' . chr(47) . chr(47) . ' ')));
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $apply) = $self->op_assign());
        if (($apply)) {
            return ($apply->emit_perl6_indented($level))
        };
        ((my  $code) = $self->{('code')});
        if ((ref(($code ne '')))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_perl6() )
            };
            return ((Perl6::tab($level) . '(' . $self->{('code')}->emit_perl6() . ')(' . join(',', @args) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>>'))) {
            return ((Perl6::tab($level) . join(', ', map($_->emit_perl6(), @{$self->{('arguments')}}))))
        };
        if ((exists($op_infix_js{$code}))) {
            return ((Perl6::tab($level) . '(' . join($op_infix_js{$code}, map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'eval'))) {
            return (('eval(perl5_to_js(' . Perl6::to_str($self->{('arguments')}->[0]) . '))'))
        };
        if ((($code eq 'undef'))) {
            return ((Perl6::tab($level) . 'Any'))
        };
        if ((($code eq 'map'))) {
            ((my  $fun) = $self->{('arguments')}->[0]);
            ((my  $list) = $self->{('arguments')}->[1]);
            return (('(function (a_) ' . chr(123) . ' ' . 'var out ' . chr(61) . ' []' . chr(59) . ' ' . 'if ( a_ ' . chr(61) . chr(61) . ' null ) ' . chr(123) . ' return out' . chr(59) . ' ' . chr(125) . chr(59) . ' ' . 'for(var i ' . chr(61) . ' 0' . chr(59) . ' i < a_.length' . chr(59) . ' i++) ' . chr(123) . ' ' . 'var v__ ' . chr(61) . ' a_[i]' . chr(59) . ' ' . 'out.push(' . $fun->emit_perl6() . ')' . chr(125) . chr(59) . ' ' . 'return out' . chr(59) . ' ' . chr(125) . ')(' . $list->emit_perl6() . ')'))
        };
        if ((($code eq 'prefix:<' . chr(33) . '>'))) {
            return ((chr(33) . '( ' . Perl6::to_bool($self->{('arguments')}->[0]) . ')'))
        };
        if ((($code eq 'prefix:<' . chr(36) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_perl6() . ')._scalar_'))
        };
        if ((($code eq 'prefix:<' . chr(64) . '>'))) {
            return (('(' . join(' ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<' . chr(37) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_perl6() . ')._hash_'))
        };
        if ((($code eq 'circumfix:<[ ]>'))) {
            return (('Array.prototype.slice.call(' . join(', ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<' . chr(92) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Var'))) {
                if ((($arg->sigil() eq chr(64)))) {
                    return ($arg->emit_perl6())
                };
                if ((($arg->sigil() eq chr(37)))) {
                    return (('(new HashRef(' . $arg->emit_perl6() . '))'))
                }
            };
            return (('(new ScalarRef(' . $arg->emit_perl6() . '))'))
        };
        if ((($code eq 'postfix:<++>'))) {
            return (('(' . join(' ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')++'))
        };
        if ((($code eq 'postfix:<-->'))) {
            return (('(' . join(' ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')--'))
        };
        if ((($code eq 'prefix:<++>'))) {
            return (('++(' . join(' ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<-->'))) {
            return (('--(' . join(' ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<+>'))) {
            return (('+(' . $self->{('arguments')}->[0]->emit_perl6() . ')'))
        };
        if ((($code eq 'exists'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Lookup'))) {
                ((my  $v) = $arg->obj());
                if ((($v->isa('Var') && ($v->sigil() eq chr(36))))) {
                    ($v = Var->new(('sigil' => chr(37)), ('namespace' => $v->namespace()), ('name' => $v->name())));
                    return (('(' . $v->emit_perl6() . ').hasOwnProperty(' . ($arg->index_exp())->emit_perl6() . ')'))
                };
                return (('(' . $v->emit_perl6() . ')._hash_.hasOwnProperty(' . ($arg->index_exp())->emit_perl6() . ')'))
            };
            if (($arg->isa('Call'))) {
                if ((($arg->method() eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
                    return (('(' . $arg->invocant()->emit_perl6() . ')._hash_.hasOwnProperty(' . $arg->{('arguments')}->emit_perl6() . ')'))
                }
            }
        };
        if ((($code eq 'ternary:<' . chr(63) . chr(63) . ' ' . chr(33) . chr(33) . '>'))) {
            return ((Perl6::tab($level) . '( ' . Perl6::to_bool($self->{('arguments')}->[0]) . ' ' . chr(63) . ' ' . ($self->{('arguments')}->[1])->emit_perl6() . ' : ' . ($self->{('arguments')}->[2])->emit_perl6() . ')'))
        };
        if ((($code eq 'circumfix:<( )>'))) {
            return ((Perl6::tab($level) . '(' . join(', ', map($_->emit_perl6(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>'))) {
            return (emit_perl6_bind($self->{('arguments')}->[0], $self->{('arguments')}->[1], $level))
        };
        if ((($code eq 'return'))) {
            return ((Perl6::tab($level) . 'return(' . ((($self->{('arguments')} && @{$self->{('arguments')}}) ? $self->{('arguments')}->[0]->emit_perl6() : 'null')) . ')'))
        };
        if (($self->{('namespace')})) {
            if (((($self->{('namespace')} eq 'Perl6') && ($code eq 'inline')))) {
                if (($self->{('arguments')}->[0]->isa('Val::Buf'))) {
                    return ($self->{('arguments')}->[0]->{('buf')})
                }
                else {
                    die(('Perl6::inline needs a string constant'))
                }
            };
            ($code = ($self->{('namespace')} . '::' . ($code)))
        };
        ((my  @args) = ());
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_perl6() )
        };
        (Perl6::tab($level) . $code . '(' . join(', ', @args) . ')')
    };
    sub emit_perl6_bind {
        ((my  $parameters) = shift());
        ((my  $arguments) = shift());
        ((my  $level) = shift());
        if (($parameters->isa('Call'))) {
            if ((($parameters->method() eq 'postcircumfix:<[ ]>'))) {
                ((my  $str) = '');
                ((my  $var_js) = $parameters->invocant()->emit_perl6());
                ((my  $index_js) = $parameters->arguments()->emit_perl6());
                ($str = ($str . 'return (' . $var_js . '[' . $index_js . '] ' . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')' . chr(59) . ' '));
                return ((Perl6::tab($level) . '(function () ' . chr(123) . ' ' . $str . chr(125) . ')()'))
            };
            if ((($parameters->method() eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
                ((my  $str) = '');
                ((my  $var_js) = $parameters->invocant()->emit_perl6());
                ((my  $index_js) = $parameters->arguments()->emit_perl6());
                ($str = ($str . 'return (' . $var_js . '._hash_[' . $index_js . '] ' . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')' . chr(59) . ' '));
                return ((Perl6::tab($level) . '(function () ' . chr(123) . ' ' . $str . chr(125) . ')()'))
            }
        };
        if (($parameters->isa('Lookup'))) {
            ((my  $str) = '');
            ((my  $var) = $parameters->obj());
            if ((($var->isa('Var') && ($var->sigil() eq chr(36))))) {
                ($var = Var->new(('sigil' => chr(37)), ('namespace' => $var->namespace()), ('name' => $var->name())));
                ((my  $var_js) = $var->emit_perl6());
                ((my  $index_js) = $parameters->index_exp()->emit_perl6());
                ($str = ($str . 'return (' . $var_js . '[' . $index_js . '] ' . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')' . chr(59) . ' '));
                return ((Perl6::tab($level) . '(function () ' . chr(123) . ' ' . $str . chr(125) . ')()'))
            };
            ((my  $var_js) = $var->emit_perl6());
            ((my  $index_js) = $parameters->index_exp()->emit_perl6());
            ($str = ($str . 'return (' . $var_js . '._hash_[' . $index_js . '] ' . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')' . chr(59) . ' '));
            return ((Perl6::tab($level) . '(function () ' . chr(123) . ' ' . $str . chr(125) . ')()'))
        };
        if (($parameters->isa('Index'))) {
            ((my  $str) = '');
            ((my  $var) = $parameters->obj());
            if ((($var->isa('Var') && ($var->sigil() eq chr(36))))) {
                ($var = Var->new(('sigil' => chr(64)), ('namespace' => $var->namespace()), ('name' => $var->name())))
            };
            ((my  $var_js) = $var->emit_perl6());
            ((my  $index_js) = $parameters->index_exp()->emit_perl6());
            ($str = ($str . 'return (' . $var_js . '[' . $index_js . '] ' . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')' . chr(59) . ' '));
            return ((Perl6::tab($level) . '(function () ' . chr(123) . ' ' . $str . chr(125) . ')()'))
        };
        if ((($parameters->isa('Var') && ($parameters->sigil() eq chr(64))) || ($parameters->isa('Decl') && ($parameters->var()->sigil() eq chr(64))))) {
            ($arguments = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => (do {
    (my  @a);
    (my  @v);
    push(@a, Lit::Array->new(('array1' => (do {
    (my  @a);
    (my  @v);
    push(@a, $arguments );
    \@a
}))) );
    \@a
}))));
            return ((Perl6::tab($level) . '(' . $parameters->emit_perl6() . ' ' . chr(61) . ' (' . $arguments->emit_perl6() . ').slice())'))
        }
        else {
            if ((($parameters->isa('Var') && ($parameters->sigil() eq chr(37))) || ($parameters->isa('Decl') && ($parameters->var()->sigil() eq chr(37))))) {
                ($arguments = Apply->new(('code' => 'prefix:<' . chr(37) . '>'), ('arguments' => (do {
    (my  @a);
    (my  @v);
    push(@a, Lit::Hash->new(('hash1' => (do {
    (my  @a);
    (my  @v);
    push(@a, $arguments );
    \@a
}))) );
    \@a
}))));
                return ((Perl6::tab($level) . '(' . $parameters->emit_perl6() . ' ' . chr(61) . ' (function (_h) ' . chr(123) . ' ' . 'var _tmp ' . chr(61) . ' ' . chr(123) . chr(125) . chr(59) . ' ' . 'for (var _i in _h) ' . chr(123) . ' ' . '_tmp[_i] ' . chr(61) . ' _h[_i]' . chr(59) . ' ' . chr(125) . chr(59) . ' ' . 'return _tmp' . chr(59) . ' ' . chr(125) . ')( ' . $arguments->emit_perl6() . '))'))
            }
        };
        (Perl6::tab($level) . '(' . $parameters->emit_perl6() . ' ' . chr(61) . ' ' . $arguments->emit_perl6() . ')')
    }
});
package If;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = $self->{('cond')});
        if ((($cond->isa('Var') && ($cond->sigil() eq chr(64))))) {
            ($cond = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => (do {
    (my  @a);
    (my  @v);
    push(@a, $cond );
    \@a
}))))
        };
        ((my  $body) = Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        ((my  $s) = (Perl6::tab($level) . 'if ( ' . Perl6::to_bool($cond) . ' ) ' . chr(123) . (chr(10)) . $body->emit_perl6_indented(($level + 1)) . (chr(10)) . Perl6::tab($level) . chr(125)));
        if ((@{$self->{('otherwise')}->stmts()})) {
            ((my  $otherwise) = Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('otherwise')}->stmts()), ('needs_return' => 0)));
            ($s = ($s . (chr(10)) . Perl6::tab($level) . 'else ' . chr(123) . (chr(10)) . $otherwise->emit_perl6_indented(($level + 1)) . (chr(10)) . Perl6::tab($level) . chr(125)))
        };
        return ($s)
    }
});
package While;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $body) = Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        return ((Perl6::tab($level) . 'for ( ' . (($self->{('init')} ? ($self->{('init')}->emit_perl6() . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('cond')} ? (Perl6::to_bool($self->{('cond')}) . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('continue')} ? ($self->{('continue')}->emit_perl6() . ' ') : ' ')) . ') ' . chr(123) . ' ' . '(function () ' . chr(123) . (chr(10)) . $body->emit_perl6_indented(($level + 1)) . ' ' . chr(125) . ')()' . ' ' . chr(125)))
    }
});
package For;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = $self->{('cond')});
        if ((!((($cond->isa('Var') && ($cond->sigil() eq chr(64))))))) {
            ($cond = Lit::Array->new(('array1' => (do {
    (my  @a);
    (my  @v);
    push(@a, $cond );
    \@a
}))))
        };
        ((my  $body) = Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        ((my  $sig) = 'v__');
        if (($self->{('body')}->sig())) {
            ($sig = $self->{('body')}->sig()->emit_perl6_indented(($level + 1)))
        };
        (Perl6::tab($level) . '(function (a_) ' . chr(123) . ' for (var i_ ' . chr(61) . ' 0' . chr(59) . ' i_ < a_.length ' . chr(59) . ' i_++) ' . chr(123) . ' ' . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . $body->emit_perl6_indented(($level + 1)) . ' ' . chr(125) . ')(a_[i_]) ' . chr(125) . ' ' . chr(125) . ')' . '(' . $cond->emit_perl6() . ')')
    }
});
package Decl;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Perl6::tab($level) . $self->{('var')}->emit_perl6())
    };
    sub emit_perl6_init {
        ((my  $self) = shift());
        ($self->{('decl')} . ' ' . ($self->{('var')})->emit_perl6() . chr(59))
    }
});
package Sub;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $s) = ('function () ' . chr(123) . (chr(10)) . Perl6::tab(($level + 1)) . 'var List__ ' . chr(61) . ' Array.prototype.slice.call(arguments)' . chr(59) . (chr(10)) . (Perlito5::Perl6::LexicalBlock->new(('block' => $self->{('block')}), ('needs_return' => 1), ('top_level' => 1)))->emit_perl6_indented(($level + 1)) . (chr(10)) . Perl6::tab($level) . chr(125)));
        (($self->{('name')} ? ('make_sub(__PACKAGE__, ' . chr(34) . $self->{('name')} . chr(34) . ', ' . $s . ')') : $s))
    }
});
package Do;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $block) = $self->simplify()->block());
        return ((Perl6::tab($level) . '(do ' . chr(123) . (chr(10)) . (Perlito5::Perl6::LexicalBlock->new(('block' => $block), ('needs_return' => 1)))->emit_perl6_indented(($level + 1)) . (chr(10)) . Perl6::tab($level) . chr(125) . ')'))
    }
});
package Use;
(do {
    sub emit_perl6 {
        $_[0]->emit_perl6_indented(0)
    };
    sub emit_perl6_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $mod) = $self->{('mod')});
        if ((($mod eq 'feature') || ($mod eq 'v5'))) {
            return ()
        };
        (Perl6::tab($level) . 'use ' . $self->{('mod')} . (chr(59)))
    }
});

1;
