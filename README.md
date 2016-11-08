# Vapor Generate

This project will make it easier for developers to work with the [Vapor Framework](https://vapor.codes) by generating some sourcecode.

## Models

This is currently the only command available. It is not failsafe, only works if used correctly.

Based on the idea of writing a basic schema for your model, this generator relies on model configs placed inside `Config/models` of the execution path.
Generated Model files will be placed in `Sources/App/Models` and **won't override any existing files**!

![Terminal](Assets/Terminal.gif?raw=true "Terminal")

The rendered code doesn't look pretty as the generator is currently using the Leaf template engine by Vapor. Indentation is a little bit off, but this generator saved much work on my side.

### Sample Model `Minimal.json`

```json
{
  "properties": [
    {
      "key": "testProperty",
      "type": "String"
    }
  ]
}
```

### Sample Model `Maximum.json` 

```json
{
  "model": "Maximus",
  "table": "maximus_items",
  "properties": [
    {
      "key": "testProperty",
      "type": "String",
      "column": "test_property"
    }
  ]
}
```

### Todo

- [ ] property extensions
      - [ ] optionals
      - [ ] default values
      - [ ] length
- [ ] relations
- [ ] fix indentation (maybe not using leaf)
