# Requirements

## 1. Program Execution
- When the program starts, it waits for user input.

## 2. Prompt Display
- While waiting for input, the program displays `# ` (including the space).

## 3. User Input
- The user enters an arithmetic expression consisting of integers and the four basic arithmetic operations, then presses Enter.
- Allowed characters in the expression:
  - Digits: `0-9`
  - Operators: `+`, `-`, `x`, `/`
  - The expression must always end with `=`.
  - Multiplication must use the lowercase letter `x`.
  - No parentheses or spaces are allowed in the expression.

**Example Input:**
- 2+3x5-2x82+123/4=

## 4. Evaluation Rules
- Operators are evaluated in the order they appear, from left to right.
- No operator precedence is applied.

## 5. Output
- The program displays:
  1. The input expression as entered.
  2. The intermediate results after each operation.
  3. The final result at the end.

- Output format example: 2+3x17-38/2= 5 85 47 23

## 6. Assumptions
- Input is always valid and adheres to the specified rules (no error handling required).
- Numbers are always non-negative, but intermediate results can be negative.
- The maximum length of the input expression is 512 characters.
- Decimal numbers are not used; all calculations are done with integers.

