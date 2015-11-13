# debugging in ruby and rails

## Intro

| Objectives                                 |
| :----                                      |
| Be able to use pry as a REPL               |
| Be able to enter objects and make changes  |
| Be able to use pry as a debugger           |
| Be able to add pry-rails and better-errors |



## pry

Pry can replace IRB as your ruby REPL of choice.  

```ruby
[1] pry(main)> 1 + 1
=> 2
[2] pry(main)> "hello".public_methods
=> [:<=>,
 :==,
 :===,
 :eql?,
 :hash,
 :casecmp,
 :+,
 :*,
 :%,
 :[],
 :[]=,
 :insert,
 :length,
 :size,
 :bytesize,
 :empty?,
 :=~,
 :match,
 :succ,
 # ... and so on

[3] pry(main)> def say_hello
[3] pry(main)*   puts 'helllllo'
[3] pry(main)* end
=> :say_hello
[4] pry(main)> say_hello
helllllo
=> nil
```
Oops, that looks like an error.  I misspeeled 'hello'.

```ruby
[6] pry(main)> show-method say_hello

From: (pry) @ line 3:
Owner: Object
Visibility: public
Number of lines: 3

def say_hello
  puts 'helllllo'
end
```
Yep, that's wrong. I'd better edit that.
```ruby
[7] pry(main)> edit say_hello
```
At this point if you're following along you would see an editor pop up and you could edit the method.  You can change the editor pry uses.


Pry offers a lot more than just access to ruby methods though. 
You can easily enter into objects and view or edit their internal methods using commands much like those you use in your terminal.
```ruby
[13] pry(main)> cd Hash
[14] pry(Hash):1> ls
Object.methods: yaml_tag
Hash.methods: []  try_convert
Hash#methods:
  ==     compare_by_identity   default_proc=  each_pair   flatten     index    key?     merge!             reject   shift  to_hash  values_at
  []     compare_by_identity?  delete         each_value  has_key?    inspect  keys     pretty_print        reject!  size   to_s
  []=    default               delete_if      empty?      has_value?  invert   length   pretty_print_cycle  replace  store  update
  assoc  default=              each           eql?        hash        keep_if  member?  rassoc              select   to_a   value?
  clear  default_proc          each_key       fetch       include?    key      merge    rehash              select!  to_h   values
locals: _  __  _dir_  _ex_  _file_  _in_  _out_  _pry_

```


### with rails

You can also show or edit methods and classes in rails.

```ruby
[14] pry(#<Book>):2> b = Book.new
=> #<Book:0x007fb7d8e79680
 id: nil,
 title: nil,
 year_published: nil,
 author: nil,
 available: nil,
 genre: nil,
 image_url: nil,
 created_at: nil,
 updated_at: nil>
[15] pry(#<Book>):2> b.title = "The Hitchhikers Guide to the Galaxy"
=> "The Hitchhikers Guide to the Galaxy"
[16] pry(#<Book>):2> cd b
[17] pry(#<Book>):3> title
=> "The Hitchhikers Guide to the Galaxy"


[31] pry(BooksController):1> find-method show
ActionController::Rescue
ActionController::Rescue#show_detailed_exceptions?
BooksController
BooksController#show
[32] pry(BooksController):1> edit BooksController

```

In order to get this working though you'll need to do a few things.

1. First add `pry-rails` and `pry-byebug` to your gemfile
2. `bundle install`
3. Now instead of using `debugger` in your ruby code to pause server-execution and debug, type `binding.pry`

It'll also help if you [add a few shortcut commands](https://github.com/deivid-rodriguez/pry-byebug#matching-byebug-behaviour) so you don't have to type `continue`, `step` etc.


####  Debugging
Since pry is a debugger we ought to be able to use typical debugger commands like:

##### continue 
- continue program execution from where it stopped

##### next
- allow code in the current line to complete
- stop at the next line in the same file (if possible)
- You can think of `next` as staying at the *same "level"*.

##### step 
- step into the code as it executes
- You can think of `step` as *"going-deeper"*.

```ruby
 arr.sort.uniq
 puts arr
```
- when paused on the above line `step` would show both the code in `sort` and in `uniq`.  `next` would just stop at the next `puts`
  
##### break
- halt execution and debug at the specified line/condition
```ruby
break 10                      # stop at line 10
break BooksController#index   # stop when #index is called 
break 10 if x > 3
```


### pry glossary

A few commands you might make use of include
- edit                   - edit a file or method
- cd                     - change current scope
- ls                     - list variables and methods
- show-method            - display a method's code
- find-method            - find all methods with this name
- help                   - 
- watch                  - print a message whenever a message changes
- show-doc               - Show documentation for a specific method 



## better errors

Better errors is a replacement for the rails error page that adds:
* a clearer stacktrace
* a fully functional REPL console
* clearer listings of params and instance variables
* souce code inspection

![better errors](https://camo.githubusercontent.com/3fa6840d5e20236b4f768d6ed4b42421ba7c2f21/68747470733a2f2f692e696d6775722e636f6d2f367a42474141622e706e67)

