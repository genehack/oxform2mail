package OXform2email::View::HTML;
use Moose;

use Text::Xslate;

has cache_dir     => ( is => 'ro' , isa => 'Str' , required => 1 );
has template_root => ( is => 'ro' , isa => 'Str' , required => 1 );

has xslate => (
  is      => 'ro' ,
  isa     => 'Text::Xslate' ,
  lazy    => 1 ,
  default => sub {
    my $self = shift;
    return Text::Xslate->new(
      cache_dir => $self->cache_dir  ,
      path      => [ $self->template_root ] ,
    );
  },
);

sub render {
  my( $self , $r , $page , $args ) = @_;

  $args //= {};
  $args->{r} = $r;

  return $self->xslate->render( "$page.tx" , $args );
}

__PACKAGE__->meta->make_immutable;
1;
