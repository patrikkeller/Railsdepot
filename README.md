#README.md

[Mein Rails Depot auf Heroku]http://pure-sunset-939.heroku.com/  <br>
[Markdown Hilfe]:http://de.wikipedia.org/wiki/Markdown



#Notizen
aus Git Console 
[[http://devcenter.heroku.com/articles/quickstart]]


$ heroku create
Creating pure-sunset-939.... done
(http://pure-sunset-939.heroku.com/) | git@heroku.com:pure-sunset-939.git

Git remote heroku added<br>
$ git add .<br>
$ git commit -m "heroku"<br>
$ git push heroku master<br>
(1x: $ heroku rake db migrate<br>
vorher Gemfile in \ anpassen, da Heroku kein sqlite3 kennt<br>

group :development, :test do<br>
gem "sqlite3-ruby", "~> 1.3.0", :require => "sqlite3"<br>
end
)<br>


$ heroku open
