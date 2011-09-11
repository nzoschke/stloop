# heroku-push

Ensure that you have the `new-releases` userpass:

    $ db core:console
    > UserPass.create(:user => User["you@heroku.com"], :feature => "new-releases")

Ensure that `slugc` is in your path:

    $ export PATH=~/state/heroku/slug-compiler/bin:$PATH

Build and push in one step from the application directory:

    $ heroku push

Build and push in separate steps:

    $ slugc --stack cedar --repo-dir $PWD/.git --output-slug /tmp/slug.img --output-release /tmp/release.yml
    $ heroku push --slug /tmp/slug.img --release /tmp/release.yml
