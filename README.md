## table schema
| User            | Label              | Task                 |
| :---:           | :---:              | :---:                |
| name:string     | task_id:references | title:string         |
| email:string    | user_id:references | content:text         |
| password:string |                    | end_date:date        |
| admin:boolean   |                    | start_status:integer |
|                 |                    | priority:integer     |
|                 |                    | user_id:bigint
<HR>

## Heroku deploy flow

### Gem
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```

### STEP
1. `git add` <br>
   `git commit` 
2. `heroku creata`
3. `bundle install`
4. `heroku buildpacks:set heroku/ruby` <br>
   `heroku buildpacks:add --index 1 heroku/nodejs`
5. `git push heroku branch:master`
6. `heroku run rails db:migrate`
7. `heroku open`

<HR>