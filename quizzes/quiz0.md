This isn't really a quiz.  It's just to get you started.

# Pry Setup
Let's first make sure you have pry:

```bash
gem install pry
```

Next let's setup pry to use *your favorite editor*.  
1) open ~/.pryrc in your editor.  (create it if necessary: `touch ~/.pryrc`)
2) add a line like below but replace `atom` with the command you use to start your favorite editor.
```bash
Pry.config.editor = "atom"
```
