# Dart

[dartpad.dev]()

## Keywords

Words reserved for the programming language — `void`, `if`.

## Data types

Type of a value — `String`, `int`.

## Constants

Values which cannot change over time — `10`, `Tangerine`.

Constants cannot change as the program is compiled nor when the program is actually run.

Compile time: packaging of the application, of the program.

```
const String name = 'Gabriele';
```

Use `const`, the type of the variable, the name of the variable. 

Assign a value with the assigment operator — `=`.

Always end statements with a semicolon.

## Variables

Values which  can change over time.

```
String name = 'Gabriele';
name = 'Gabrie';
```
## final

In dart use the `final` keyword to mark values which cannot change over time.
```
final String name = 'Gabriele';
```
`final` variables are similar to constants, but unlike constants they can be declared without an initial value.
```
final String name;
```
Once the value is assigned dart will ensure the value cannot change.

## Function

Grouping of code.
```
void main() {
    runApp();
}
```
In general terms define a function specifying the return type — `void` if nothing is returned — the name of the function and parameters in between parens.
```
int getDouble(n) {
    return n * 2;
}
```
After you define the function execute the logic by calling the function.
```
int double = getDouble(3);
```

## String formatting

Concatenate strings with the plus sign `+`.

```
```

Use variables in string prefacing the name of the variable with the question mark character `?`.

```
print(')
```

## Arrow function

Function shorthand for when you return a single value.

int getDouble = (n) => n * 2;
