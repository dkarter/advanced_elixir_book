# Advanced Functional Programming with Elixir

This repo is where I practice and improve upon examples from the book:

[Advanced Functional Programming with Elixir](https://pragprog.com/titles/jkelixir/advanced-functional-programming-with-elixir/) by Joseph Koski

The book provides a large code example repository and livebook - but everything
is typed up which hurts learning in my opinion.

The best way to learn is by typing stuff by hand and coming up with
improvements that better fit my style and tools/techniques I already use.

## Improvements so far

1. Use [Zoi](https://hexdocs.pm/zoi/readme.html) to create types, validation, struct fields - instead of bare structs with no validation
2. Rename `make` to `new` on structs
3. Re-use struct schema for opts validation
4. Default to using named arguments for functions (this is not great to read `FunPark.Patron.make("Alice", 15, 120, fast_passes: [fast_pass])`)
