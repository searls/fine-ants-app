# fine_ants_app 🐜

This is a little Rails app that uses the
[fine_ants](https://github.com/searls/fine_ants)  🐜 gem to aggregate personal account standings and tally them up by taking snapshots using Capybara (e.g. scraping them with browsers). It's meant to be run locally.

<img width="669" alt="screen shot 2016-08-07 at 11 44 03 am" src="https://cloud.githubusercontent.com/assets/79303/17463468/52e93330-5c94-11e6-889d-43566c51f4ba.png">

## setup

**This app isn't secured! At all! It's meant to be run locally! Don't go
deploying it to Heroku or Google or the Cloud!**

### install

```
$ git clone git@github.com:searls/fine_ants_app.git #  🐜
$ cd fine_ants_app
$ bundle
$ bundle exec rake db:create db:migrate
$ bundle exec rails s -b 127.0.0.1
```

That'll get the server going at [http://localhost:3000](http://localhost:3000).

### create stuff

1. Create a bank (e.g. named "Vanguard", adapter "vanguard")
[here](http://localhost:3000/admin/banks/new)
2. Create a user for that 🐜 bank with your user and password
[here](http://localhost:3000/admin/users/new)
3. Head 🐜 back to the [dashboard](http://localhost:3000/) and click
"Update Accounts" to kick off update process. This will save off `Snapshot`
models for each of your accounts
4. After the 🐜 update finishes, your dashboard should tally up your accounts based
on their latest snapshots, giving you the grand total

## secure your data

I secure my data on an encrypted disk image. I do this with Disk Utility:

![screen shot 2016-08-07 at 12 18 40 pm](https://cloud.githubusercontent.com/assets/79303/17463676/1f8db934-5c99-11e6-99d1-18f3bffe7b82.png)

With the disk image mounted to `/Volumes/fine_ants_data`, I then set up symlinks
to my local databases:

```
$ cd db
$ ln -s /Volumes/fine_ants_data/development.sqlite3 .
$ ln -s /Volumes/fine_ants_data/test.sqlite3 .
```

Then, when starting my app, I start by opening (and decrypting the local disk
image) with:

```
$ open db/data.dmg
# Which will prompt me for the image's password
$ rails s
```

Since it's so easy to encrypt your local data in OS X, this is a good enough
safeguard against accidentally sharing your personal financial information when
moving around code and projects, which most people typically think of as safe.
