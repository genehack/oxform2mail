package OXform2email;
# ABSTRACT: OX advent form2email example
use OX;
use 5.016;

has cache_dir     => ( is => 'ro' , isa => 'Str' , required => 1 );
has template_root => ( is => 'ro' , isa => 'Str' , required => 1 );

has view => (
  is           => 'ro' ,
  isa          => 'Text::Xslate' ,
  dependencies => {
    cache_dir => 'cache_dir' ,
    path      => 'template_root' ,
  },
);

has verifier_config => ( is => 'ro' , isa => 'HashRef' , required => 1 );

has verifier => (
  is           => 'ro' ,
  isa          => 'Data::Verifier',
  dependencies => [ 'verifier_config' ] ,
  block        => sub { Data::Verifier->new( shift->param( 'verifier_config' )) } ,
);

has form_c => (
  is    => 'ro' ,
  isa   => 'OXform2email::Controller::Form',
  infer => 1 ,
);

router as {
  route '/'       => 'form_c.index';
  route '/post'   => 'form_c.post';
  route '/thanks' => 'form_c.thanks';
};

__PACKAGE__->meta->make_immutable;
1;
