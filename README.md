#README.md

Mein Rails Depot auf Heroku [["http://pure-sunset-939.heroku.com/"]]
Markdown hilfe [["http://de.wikipedia.org/wiki/Markdown"]]

#Notizen
aus Git Console 
http://devcenter.heroku.com/articles/quickstart
$ heroku create
Creating pure-sunset-939.... done
"http://pure-sunset-939.heroku.com/" | git@heroku.com:pure-sunset-939.git
Git remote heroku added
$ git add .
$ git commit -m "heroku"
$ git push heroku master
(1x: $ heroku rake db migrate
vorher Gemfile in \ anpassen, da Heroku kein sqlite3 kennt

group :development, :test do
gem "sqlite3-ruby", "~> 1.3.0", :require => "sqlite3"
end
)
$ heroku open
