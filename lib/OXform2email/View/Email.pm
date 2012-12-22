package OXform2email::View::Email;
use Moose;

use Email::Sender::Simple qw/ sendmail /;
use Email::Simple;
use Email::Simple::Creator;

sub send_email {
  my( $data ) = @_;

  my $email = Email::Simple->create(
    header => [
      To      => $data->{to} ,
      From    => '"OX Form2Email" <donotreply@example.com>' ,
      Subject => $data->{submject} ,
    ] ,
    body => $data->{body},
  );

  sendmail( $email );
};

__PACKAGE__->meta->make_immutable;
1;
