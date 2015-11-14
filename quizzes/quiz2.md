**Question: Assuming the following code is loaded in pry, how can I list the methods in the Cow class**

```ruby
class Cow
  def say_hello
    puts "yo"
  end

  def eat
    puts "nom nom"
  end

  def sleep
    puts "zzzzzzzzz"
  end
end
```

Select all that apply.
1. `ls Cow`
2. `edit Cow`
3. ```
    cd Cow
    ls
  ```
4. `pry.Cow`













































Solution:

**Both 1 and 3** are correct.

1) `ls Cow`


3) ```
    cd Cow
    ls
  ```

You could also try

```ruby
cow1 = Cow.new
cd cow1
ls
```
