# html-haskell

A simple, light-weight server that transpiles Haskell code to HTML. 

This project arose from the need to build React components using Haskell. Under the hood, html-haskell uses [type-of-html](https://github.com/knupfer/type-of-html). Look at type-of-html to see what Haskell code you can write and how it is transformed to HTML.

### Example:

Haskell code:

```haskell
render = div_A (A.style_ "color: red") "HELLO WORLD!"
```

Resulting HTML:

```html
<div style="color: red">HELLO WORLD!</div>
```

## API

### /transpile
Make a POST request to ```/transpile``` with the following payload as JSON:

```json
{
  code: "code to transpile"
}
```

**Important:** The code has to be formatted as shown in the example above, providing the ```render``` function that returns a Haskell-HTML.

### /status
You can check the status of the service with a simple GET request to ```/status```. If everything is okay, 200 should be returned.

## Docker 

You can find this server as a docker image under [julianbrendl/html-haskell](https://hub.docker.com/r/julianbrendl/html-haskell/).