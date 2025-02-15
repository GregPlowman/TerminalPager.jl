Usage
=====

## Getting started

The pager is called using the function `pager`. If the input object is not a
`AbstractString`, then it will be rendered using `show` with `MIME"text/plain"`.  Thus, you
can browse a large matrix, for example, using:

```julia-repl
julia> rand(100,100) |> pager
```

It is also possible to use the `pager` to browse the documentation of a specific function:

```julia-repl
julia> @doc(write) |> pager
```

All the functionalities can be seen in the built-in help system, accessible by typing `?`
inside the `pager`.

## Helpers

The following macros are available to help calling the pager.

### `@help`

This macro calls the help of any function and redirects it to the `pager`:

```julia-repl
julia> @help write
```

![](../assets/dpr_01.png)

### `@stdout_to_pager`

This macro redirects all the `stdout` to the pager after the command is completed:

```julia-repl
julia> @stdout_to_pager show(stdout, MIME"text/plain"(), rand(100,100))
```

![](../assets/stdout_to_pager_01.png)

This macro also works with blocks such as `for` loops:

```julia-repl
julia> @stdout_to_pager for i = 1:100
       println("$(mod(i,9))"^i)
       end
```

![](../assets/stdout_to_pager_02.png)

!!! note
    This macro can also be called using the shorter name `@out2pr`.
