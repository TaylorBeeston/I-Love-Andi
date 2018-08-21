# i-love-andi.com

This is the source code for the website [i-love-andi.com](i-love-andi.com)

## License

All source code is available under the MIT License, see [LICENSE.md](LICENSE.md)
for more information

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that eveything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```