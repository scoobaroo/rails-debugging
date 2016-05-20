# debugging in ruby and rails

## Intro

| Objectives                                       |
| :----                                            |
| Use pry as a REPL                     |
| Enter objects and make changes from pry        |
| Debug Rails projects with `binding.pry` and standard debugger commands |


## `pry` as REPL

#### Read, Evaluate, Print, Loop

The gem [`pry`](https://github.com/pry/pry) can replace IRB as your ruby REPL of choice.  

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


#### Edit via Command Line

Oops, that looks like an error.  I misspelled 'hello'.

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

At this point, if you're following along, an editor will have opened so you can edit the method.  You can change which editor `pry` opens; see [exercise 0](./exercises/exercise0.md).

#### Going Deeper into Objects

Pry also lets you "enter into" Ruby objects and view or edit their internal methods using commands much like those you use to navigate your terminal.

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
#### Exercise 0 - 2
* Follow along in [exercise 0](./exercises/exercise0.md) to install `pry` and configure it to use your favorite text editor.  
* Learn about `cd` and `ls` in [exercise 1](./exercises/exercise1.md).
* Mooove on to [exercise 2](./exercises/exercise2.md), and fix the `Cow#say_hello` method through `pry`.


## Pry and Rails

Let's look at how you can use Pry in Rails.


In order to get this working you'll need to do a few things.

1. First add [`pry-rails`](https://github.com/rweng/pry-rails) and [`pry-byebug`](https://github.com/deivid-rodriguez/pry-byebug) to your Gemfile. This changes your Rails console and [byebug](https://github.com/deivid-rodriguez/byebug) to use `pry` instead of plain `irb`.
2. If you are unfamiliar with any of the gems listed above, read the basics of their documentation.
3. `bundle install`
4. Type `binding.pry` to set a breakpoint in your code.


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



##  Debugging with `binding.pry`

Since we're using a debugger, let's talk about a few debugger basics.  

Most debuggers have a feature called `breakpoint`s.  When you add a breakpoint to your code and run the code again, execution of the code will pause at the breakpoint, and your debugger will let you inspect the current state of your running program.  Some breakpoints are created by inserting a debugger command.  In Rails, by default, that command is `debugger`. Now that we're using `pry`, we'll use `binding.pry` instead.

We can also use the debugger's `break` command to add more break-points.

#### `break`
- halt execution and debug at the specified line/condition

```ruby
break 10                      # stop at line 10
break BooksController#index   # stop when #index is called
break 10 if x > 3
```

#### `continue`
- continue program execution from where it stopped
- exit the debugger (until another breakpoint is hit)

#### `next`
- allow code in the current line to complete
- stop at the next line in the same file or level (if possible)
- you can think of `next` as staying at the *same "level"*
- commands on the current line are completed before you can use the debugger commands again

#### `step`
- step into the code as it executes
- you can think of `step` as *"going-deeper"*

```ruby
 15   binding.pry
 16   arr.sort.uniq
 17   puts arr
```
When paused on line 16 above, `step` would move through the code in the `sort` and `uniq` methods.  On the other hand, `next` would skip forward to the next line on this level, stopping at `puts`.



## pry glossary

A few commands you might make use of include
- edit                   - edit a file or method
- cd                     - change current scope
- ls                     - list variables and methods
- show-method            - display a method's code
- find-method            - find all methods with this name
- help                   -
- watch                  - print a message whenever a variable changes
- show-doc               - Show documentation for a specific method


It'll also help if you [add a few shortcut commands](https://github.com/deivid-rodriguez/pry-byebug#matching-byebug-behaviour) so you don't have to type `continue`, `step` etc.

## better errors

Better errors is a replacement for the rails error page that adds:
* a clearer stacktrace
* a fully functional REPL console
* clearer listings of params and instance variables
* source code inspection

![better errors](https://camo.githubusercontent.com/3fa6840d5e20236b4f768d6ed4b42421ba7c2f21/68747470733a2f2f692e696d6775722e636f6d2f367a42474141622e706e67)

## annotate

The annotate gem can make working with your models a little easier, as it automatically adds comments to your model files to reflect the state of your database.

Just install the gem and run the `annotate` command in your terminal.
```bash
gem 'annotate'
```

Schema information will be added as comments to the top of each of your models.  You should run `annotate` after each migration.
```
# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  title          :string
#  year_published :integer
#  author         :string
#  available      :boolean
#  genre          :string
#  image_url      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
```
