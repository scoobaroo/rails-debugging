# setup

Run the following as per usual:

```bash
bundle
rake db:create
rake db:migrate
rake db:seed
rails s
```

## exercises

### Part A - add the gems

Add `pry-rails` and `pry-byebug` to your Gemfile and then `bundle install`.  These should go under development & test group.

Now start your `rails console` and observe its new pry-powers.  Feel free to explore.

### Part B - find the bug

Next run `rails s` and visit the site.  If you look at the list of books and click each book you'll notice something funny about the second one.

Don't see it?  It's taking you to the same book as the first.

### Part C - debug

That sounds like a bug in our controller.
Let's add a `binding.pry` to the appropriate method in the BooksController and re-visit that link.

This time when you click the link you should see pry open in the terminal running `rails s`.

Check what the value of @book is.  **Is that correct?**

Let's add a breakpoint for the line where we set @book.
Use something like `break 10` to break on line 10.

Then `continue` to allow it to finish.  We need to continue here because we're already past that line in the running code.

Let's go back to the page and refresh so it hits our `#show` method again.  This time it should stop at `@book = get_book`
Let's use `step` to step into the get_book method.  Pry will show us the code here.

**Does anything look wrong?**

### Part D - debug and fix

Let's use `edit get_book` to edit this method.  Then use `next` to continue back on out to the `#show` method.

Check the value of @book here.  Does it look right yet?  If not try re-setting it using our newly edited version of `get_book`.  Remember pry is a REPL too so we can run our own Ruby code and alter the outcome.

```ruby
@book = get_book
```

Now how does it look?

Use `continue` or `next` to finish your debugging.  Then test the solution.
