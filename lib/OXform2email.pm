package OXform2email;
# ABSTRACT: OX advent form2email example
use OX;
use 5.016;

has email_subject => ( is => 'ro' , isa => 'Str' , required => 1 );
has email_to      => ( is => 'ro' , isa => 'Str' , required => 1 );

has email_view =>(
  is           => 'ro' ,
  isa          => 'OXform2email::View::Email' ,
  dependencies => [ qw/ email_subject email_to / ] ,
);

has cache_dir     => ( is => 'ro' , isa => 'Str' , required => 1 );
has static_root   => ( is => 'ro' , isa => 'Str' , required => 1 );
has template_root => ( is => 'ro' , isa => 'Str' , required => 1 );

has html_view => (
  is           => 'ro' ,
  isa          => 'OXform2email::View::HTML' ,
  dependencies => [ qw/ cache_dir template_root / ] ,
);

has verifier_config => ( is => 'ro' , isa => 'HashRef' , required => 1 );

has verifier => (
  is           => 'ro' ,
  isa          => 'Data::Verifier',
  dependencies => [ 'verifier_config' ] ,
  block        => sub {
    Data::Verifier->new( shift->param( 'verifier_config' ))
  } ,
);

has controller => (
  is    => 'ro' ,
  isa   => 'OXform2email::Controller',
  infer => 1 ,
);

router as {
  wrap 'Plack::Middleware::Static' => (
    root => 'static_root',
    path => literal( qr{^/(?:css)/} ),
  );

  route '/' => 'controller' , ( name => 'index' );
};

__PACKAGE__->meta->make_immutable;
1;
