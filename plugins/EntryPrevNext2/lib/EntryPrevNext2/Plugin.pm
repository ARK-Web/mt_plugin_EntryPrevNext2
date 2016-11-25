package EntryPrevNext2::Plugin;

use strict;
use MT::Util qw( weaken );

sub _hdlr_entry_previous {
    _hdlr_entry_nextprev( 'previous', @_ );
}

sub _hdlr_entry_next {
    _hdlr_entry_nextprev( 'next', @_ );
}

sub _hdlr_entry_nextprev {
    my ( $meth, $ctx, $args, $cond ) = @_;
    my $e = $ctx->stash('entry')
        or return $ctx->_no_entry_error();
    my $terms = { status => MT::Entry::RELEASE() };
    $terms->{by_author} = 1 if $args->{by_author};
    $terms->{by_category} = 1 if $args->{by_category} || $args->{by_folder};
#    my $entry = $e->$meth($terms);
    my $entry = _nextprev($e, $meth, $terms);
    my $res   = '';
    if ($entry) {
        my $builder = $ctx->stash('builder');
        local $ctx->{__stash}->{entry} = $entry;
        local $ctx->{current_timestamp} = $entry->authored_on;
        my $out = $builder->build( $ctx, $ctx->stash('tokens'), $cond );
        return $ctx->error( $builder->errstr ) unless defined $out;
        $res .= $out;
    }
    $res;
}

sub _nextprev {
    my $obj   = shift;
    my $class = ref($obj);
    my ( $direction, $terms ) = @_;
    return undef unless ( $direction eq 'next' || $direction eq 'previous' );
    my $next = $direction eq 'next';

    $terms->{author_id} = $obj->author_id if delete $terms->{by_author};
    if ( delete $terms->{by_category} ) {
        if ( my $c = $obj->category ) {
            $terms->{category_id} = $c->id;
        }
        else {
            return undef;
        }
    }

    my $label = '__' . $direction;
    $label .= ':author=' . $terms->{author_id} if exists $terms->{author_id};
    $label .= ':category=' . $terms->{category_id}
        if exists $terms->{category_id};
    return $obj->{$label} if $obj->{$label};

    my $args = {};
    if ( my $cat_id = delete $terms->{category_id} ) {
        my $join = MT::Placement->join_on( 'entry_id',
            { category_id => $cat_id,
              is_primary => 1,
            } );
        $args->{join} = $join;
    }

    my $o = $obj->nextprev(
        direction => $direction,
        terms => { blog_id => $obj->blog_id, class => $obj->class, %$terms },
        args  => $args,
        by => ( $class eq 'MT::Page' ) ? 'modified_on' : 'authored_on',
    );
    weaken( $obj->{$label} = $o ) if $o;
    return $o;
}

1;
