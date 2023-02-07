defmodule Week2 do
    # Write a function that determines whether an input integer is prime
    def isPrime?(n) do
      if n == 0 || n == 1 || n == 2 do
        false
      else
        Enum.all?(2..(n - 1), fn i -> rem(n, i) != 0 end)
      end
    end
    # Write a function to calculate the area of a cylinder, given it’s height and radius
    def cylinderArea(height, radius) do
      2 * :math.pi * radius * (radius + height)
    end
    # Write a function to reverse a list.
    def reverse(list) do
      Enum.reverse(list)
    end
    # Write a function to calculate the sum of unique elements in a list.
    def uniqueElements(list) do
      Enum.sum(Enum.uniq(list))
    end
    # Write a function that extracts a given number of randomly selected elements from a list
    def randomNumbers(list, n) do
      Enum.take_random(list, n)
    end
    # Write a function that returns the first n elements of the Fibonacci sequence
    def firstFibonacci(1), do: [1]

    def firstFibonacci(2), do: [1, 1]

    def firstFibonacci(n) do
      fibonacci = firstFibonacci(n - 1)
      next_fibonacci = Enum.at(fibonacci, n - 3) + Enum.at(fibonacci, n - 2)
      fibonacci ++ [next_fibonacci]
    end
    # Write a function that, given a dictionary, would translate a sentence. Words not found in the dictionary need not be translated.
    def translator(dict, str) do
      str
      |> String.split(" ")
      |> Enum.map(fn word -> Map.get(dict, String.to_atom(word), word) end)
      |> Enum.join(" ")
    end
    # Write a function that receives as input three digits and arranges them in an order that would create the smallest possible number. Numbers cannot start with a 0
    def smallestNumber(a, b, c) do
      list = [a, b, c]
      list = Enum.sort(list)
      if List.first(list) == 0 do
        if Enum.at(list, 1) == 0 do
          [Enum.at(list, 2), 0, 0]
        else
          [Enum.at(list, 1), 0, Enum.at(list, 2)]
        end
      else
        list
      end
    end
    # Write a function that would rotate a list n places to the left
    def rotateLeft(list, 0), do: list

    def rotateLeft(list, n) when n > 0 do
      [first | last] = list
      rotateLeft(last ++ [first], n - 1)
    end
    # Write a function that lists all tuples a, b, c such that a2+b2 = c2 and a, b ≤ 20
    def listRightAngleTriangles() do
      for a <- 1..20, b <- 1..20,
      c = :math.floor(:math.sqrt(a*a + b*b)),
      c*c == a*a + b*b, do: {a, a, c}
    end
    #  Write a function that eliminates consecutive duplicates in a list.
    def removeConsecutiveDuplicates(list) do
      Enum.dedup(list)
    end

end
