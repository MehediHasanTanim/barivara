# Features

Each Bari Vara feature is organized as a vertical slice:

```text
feature_name/
  data/
  domain/
  application/
  presentation/
```

Feature code may depend on `core` and `shared`; it should not directly depend
on another feature's data layer.
