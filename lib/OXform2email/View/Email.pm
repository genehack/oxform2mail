package OXform2email::View::Email;
use Moose;

use Data::Printer;
use Email::Sender::Simple qw/ sendmail /;
use Email::Simple;
use Email::Simple::Creator;

has email_subject => ( is => 'ro' , isa => 'Str' , required => 1 );
has email_to      => ( is => 'ro' , isa => 'Str' , required => 1 );

sub send_email {
  my( $self , $data ) = @_;

  my $body = p $data;

  my $email = Email::Simple->create(
    header => [
      To      => $self->email_to ,
      From    => '"OX Form2Email" <donotreply@example.com>' ,
      Subject => $self->email_subject ,
    ] ,
    body => $body ,
  );

  sendmail( $email );
};

__PACKAGE__->meta->make_immutable;
1;
