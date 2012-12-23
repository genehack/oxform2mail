package OXform2email::Controller;
use Moose;

has email_view => (
  is       => 'ro' ,
  isa      => 'OXform2email::View::Email' ,
  required => 1 ,
  handles  => [ qw/ send_email / ] ,
);

has html_view => (
  is       => 'ro',
  isa      => 'OXform2email::View::HTML',
  handles  => [ qw/ render / ] ,
  required => 1 ,
);

has verifier => (
  is       => 'ro' ,
  isa      => 'Data::Verifier',
  handles  => [ qw/ verify / ] ,
  required => 1 ,
);

sub get {
  my( $self , $req ) = @_;

  # a GET means that we need to show a blank form...
  $self->render( $req , 'index' );
}

sub post {
  my( $self , $req ) = @_;

  # a POST means we need to process a submission and either show the thanks
  # page or redisplay the form

  my $results = $self->verify( $req->parameters );

  if ( $results->success ) {
    $self->send_email({ $results->valid_values });
    $self->render( $req , 'thanks' );
  }
  else {
    $self->render( $req , 'index' , { dv => $results });
  }
}

__PACKAGE__->meta->make_immutable;
1;
