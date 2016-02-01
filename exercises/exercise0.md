# Pry Setup
Let's first make sure you have pry:

```bash
gem install pry
```

Next let's setup pry to use *your favorite editor*.  
1) open ~/.pryrc in your editor.  (create it if necessary: `touch ~/.pryrc`)
2) add a line like below but replace `vim` with the command you use to start your favorite editor.
```bash
Pry.config.editor = "vim"
```

**Important**: If you use a GUI editor make sure you configure it to *wait*.  If you don't do this pry will not re-read the file and incorporate it's changes.

For example if you use `subl`: `Pry.config.editor = 'subl -w'`
For example if you use `atom`: `Pry.config.editor = 'atom -w'`


At this point pry should be working for you.

# Check

In your terminal run `pry` just like you would `irb`.  Try a few basic things you might do in `irb` or type `help`.
