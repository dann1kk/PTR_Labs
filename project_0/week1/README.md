# Real-Time Programming Week 1 

### University: _Technical University of Moldova_
### Faculty: _Computers, Informatics and Microelectronics_
### Department: _Software Engineering and Automatics_
### Author: _Daniel Pogorevici_
** **

## Tasks
1. Write a script that would print the message “Hello PTR” on the screen
```
IO.puts("Hello PTR")
``` 
2. Create a unit test for your project.
``` 
defmodule Week1Test do
  use ExUnit.Case

  test "Hello PTR" do
    assert IO.puts("Hello PTR") == :ok
  end
end
```
** **
## Execution 
### Run in the terminal following commands:
- Print the message on the screen
```
elixir lib/week1.ex
```
- Run the unit test
```
mix test
```





