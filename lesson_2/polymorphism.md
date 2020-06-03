# Polymorphism

Refers to the ability of different objects to respond in different ways to the same message (or method invocation).

## Polymorphism through inheritance

```ruby
class Animal
  def eat
    # generic eat method
  end
end

class Fish < Animal
  def eat
    # eating specific to fish
  end
end

class Cat < Animal
  def eat
    # eating specific to cat
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Cat.new]

array_of_animals.each do |animal|
  feed_animal(animal)
end
```
In the example above, even though every object in the array is a different animal, they can all be treated as a generic animal object: an object that can eat. The public interface that this code provides lets us work with each object in the same way even though they could be dramatically different.

## Polymorphism through duck typing

Duck typing is based on the following idea:

> If an object quacks like a duck and swims like a duck, it's probably a duck (so treat it like one).

In other words, if an object looks like an array (or string, hash, etc), then go ahead and treat it like an array.

For example,

```ruby
a = [1, 2, 3]
a.map { |i| i.to_s } # => ['1', '2', '3']
```
The variable `a` responds to `map` and returns the expected object so it's probably safe to assume that `a` is an Array.

In Ruby, ducky typing doesn't concern itself with the class of an object - it concerns itself with the methods that are available to that object.

Here's an example of implementing polymorphism with ducky typing in OO:

```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_foods(guests)
    # implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    # implementation
  end
end
```
In the code above, we can see that, even without inheritance, the combination of polymorphism and duck typing gives us very flexible code that can be added to without needing to make changes in more than one place.

For example, if we wanted to add a `Photographer` class, we would simply need to create a new class and implement a `prepare_wedding` method in that class which would response to the `prepare_wedding` method call in the `Wedding#prepare` method.

Polymorphism gives us the ability to have multiple different objects (`Chef` object, `Decorator` object, etc) respond to the same message (`prepare_wedding`) with a different result (`Chef` objects perform different functions with `prepare_wedding` than do `Decorator` objects.) 

Duck typing provides us with this code:

```ruby
  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
```

Here, `prepaper` could be a `Chef`, `Decorator`, or `Musician` object. Because we implemented a `prepare_wedding` method in each of those classes and because we know that an object will only respond to a method available in its Class (or superclass), we know the appropriate `prepare_wedding` method will be executed the corresponding class. If an object responds to the `Chef` version of `prepare_wedding`, then it must be a `Chef` object! We *don't* (and shouldn't!) need to explicitly code something like this: 

```ruby
def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
```
The code above is inflexible and easily broken. If we need to add a preparer in the future, not only do we need to add a new class, but we need add to our case statement above which could quickly get out of hand. 