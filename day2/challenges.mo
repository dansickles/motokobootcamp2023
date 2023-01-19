import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";
import Blob "mo:base/Blob";
import Nat8 "mo:base/Nat8";

actor DAY2 {

// 1.  Write a function average_array that takes an array of integers and returns the average value of the elements in the array.
    public func sum_of_array(nums: [Nat]): async Nat {
        Array.foldLeft<Nat,Nat>(nums, 0, func(accum, n) = accum + n);
    };

// 2.  Character count: Write a function that takes in a string and a character, and returns the number of occurrences of that character in the string.
    public func count_character(t : Text, c : Char): async Nat {
        Iter.size(Iter.filter<Char>(t.chars(), func(c1) = Char.equal(c1, c)));
    };
  
// 3.  Write a function factorial that takes a natural number n and returns the factorial of n.
    public func factorial(n: Nat): async Nat {
        Array.foldLeft<Nat, Nat>(Iter.toArray(Iter.range(1, n)), 1, func(accum, m) = accum * m);
    };

// 4. Write a function number_of_words that takes a sentence and returns the number of words in the sentence.
    public func number_of_words(t : Text): async Nat {
        Iter.size(Text.tokens(t, #char ' '));
    };

// 5.  Write a function find_duplicates that takes an array of natural numbers and returns a new array containing all duplicate numbers. The order of the elements in the returned array should be the same as the order of the first occurrence in the input array.
    public func find_duplicates(a : [Nat]): async [Nat] {
        let duplicates = Buffer.Buffer<Nat>(a.size());
        let counts = HashMap.HashMap<Nat, Nat>(10, Nat.equal, Hash.hash);
        for (number in a.vals()) {
            let current = counts.get(number);
            let newval = switch(current) {
                case(null) 1;
                case(?val) {duplicates.add(number); val + 1;}
            };
            counts.put(number, newval);
        };
        duplicates.toArray();

    };

// 6.  Write a function convert_to_binary that takes a natural number n and returns a string representing the binary representation of n.

    // NOTE: This returns a string. Not sure what it is though :-|
    public func convert_to_binary(n : Nat): async Text {
        let encoded: Blob = Text.encodeUtf8(Nat.toText(n));
        Array.foldLeft<Text, Text>(Array.map<Nat8, Text>(Iter.toArray(encoded.vals()), Nat8.toText), "", func(a,b) = a # b );
    };

}