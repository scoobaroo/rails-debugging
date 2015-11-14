# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Book.create(title: 'To Kill a Mockingbird',
            author: 'Harper Lee',
            year_published: 1960,
            image_url: 'https://s3-us-west-2.amazonaws.com/sandboxapi/to_kill_a_mockingbird.jpg'
           )

Book.create(title: 'The Four Hour Workweek',
            author: 'Tim Ferriss',
            year_published: 2007,
            image_url: 'https://s3-us-west-2.amazonaws.com/sandboxapi/four_hour_work_week.jpg'
           )
