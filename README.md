Structure of this repo:

Files and directories are organized in this pattern:

```text
<yymmdd>_<ShortTopicTitle>/{presentation/[*.md,*.pdf,*.pptx,...],
                           codelabs/[example1, example2,..]}}
                          
```

For example, this bash command creates directory structure for "Benchmarking" topic:

```bash

mkdir -p $(date +%y%m%d)_Benchmarking/{presentation,codelabs}

```


