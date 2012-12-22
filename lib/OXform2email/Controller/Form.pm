package OXform2email::Controller::Form;
use Moose;

use HTTP::Throwable::Factory qw/ http_throw /;

has mailer => (
  is       => 'ro' ,
  isa      => 'OXform2email::View::Email' ,
  required => 1 ,
  handles  => [ qw/ send_email / ] ,
);

has verifier => (
  is       => 'ro' ,
  isa      => 'Data::Verifier',
  required => 1 ,
);

has view => (
  is       => 'ro',
  isa      => 'Text::Xslate',
  handles  => [ qw/ render / ] ,
  required => 1 ,
);

sub index {
  my( $self , $req ) = @_;

  $self->render( 'index.tx' , {

  });
}

sub post {
  my( $self , $req ) = @_;

  $self->verifier->verify( $req->parameters );

  $self->send_email({
    to      => ,
    subject => ,
    body    => ,
  });

  http_throw( SeeOther => { location => '/thanks' });
}

sub thanks {
  my( $self , $req ) = @_;

  $self->render( 'thanks.tx' , {
    title => 'Thanks For Your Input' ,
  });
}

__PACKAGE__->meta->make_immutable;
1;
