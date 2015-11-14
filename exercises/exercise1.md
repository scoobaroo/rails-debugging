# explorational programming

Let's use pry to explore within some ruby objects we already know.  We'll also learn a little bit about scope.

In your terminal start pry.
```bash
$ pry
```

1. Create a method called `hello_world`
Use the method.
2. Create a hash and save it as `my_hash`
```ruby
my_hash = { name: 'tgaff', email: 'tgaff@tgaff.com' }
```

3. Explore your hash using the `cd` and `ls` commands.  Try to call some of the instance methods available to you like `#keys`.

Question: Can you still use `hello_world` here?  Why?

4. While still inside `my_hash` add a new instance method called `crazy_hash` that `puts 'crazy'`.  Then `cd` back out of `my_hash` and try to call `crazy_hash`.  

5. What object is `crazy_hash` bound to?  Do you think it will exist on new instances of Hash?  
