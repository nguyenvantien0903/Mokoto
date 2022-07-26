import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Prim "mo:prim";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Error "mo:base/Error";

actor {

  type ClassicHashMap = HashMap.HashMap<Char, Nat>;

  public func test() : async () {
    let a : Text = "makoto nijima";
    
    for (char in a.chars()){
      Debug.print(debug_show(char));
    };
  };

  public func null_or_nat(n: ?Nat) : async Text {
    switch(n) {
      case(null) {
        return("null");
      };
      case(?n) {
        return ("input is " # Nat.toText(n)); 
      };
    };
  };

  public func checkif(a : [Nat], b : Nat) : async ?Nat {
    let whoknowwhat = func(n : Nat) : Bool {
      if(n == b) { return true;} else {return false};
    };
    return Array.find<Nat>(a, whoknowwhat);
  };


  public func decimal_to_bits(n : Nat) : async Text {
    var text = "";
    var N : Nat = n;

    while (N > 0){
      text := Nat.toText(N % 2) # text;
      N := (N - (N % 2))/2;
    };
    return text;
  };


  public func nat_to_nat8(n : Nat) : async Nat8 {
    if (n < 128) {
      return (Nat8.fromNat(n));
    } else {
      throw Error.reject("\nThis is not possible\nIt cannot be done.\nIt is beyond the grasp of mortals.");
      return 0;
    };
  };

  public func max_number_with_n_bits(n : Nat) : async Nat {
    return (2**n - 1);
  };

  public func capitalize_character(c : Char) : async Char {
    Debug.print(debug_show(Prim.charToUpper(c)));
    return (Prim.charToUpper(c));
  };

  public func capitalize_text(t : Text) : async Text {
    return Text.map(t , Prim.charToUpper);
  };

  public func is_inside(t : Text, c : Char) : async Bool {
    for (char in Text.toIter(t)) {
      if (char == c) { return true; }
    };
    return false;
  };

  public func trim_whitespace(t : Text) : async Text {
    try {
      return Text.trim(t, #char ' ');
    } catch (e) {
      return t;
    };
  };

  public func size_in_bytes(t : Text) : async Nat {
    var bytes_needed = 0;
    for (char in t.chars()){
      if (Char.toNat32(char) <= 0x7F) { bytes_needed += 1 } 
      else if (Char.toNat32(char) < 0x7FF) { bytes_needed += 2 }
      else if (Char.toNat32(char) < 0xFFFF) { bytes_needed += 3 }
      else {bytes_needed += 4};
    };
    
    return bytes_needed;
  };

  public func bubble_sort(array : [Nat]) : async [Nat] {
    let n = array.size();
    var workingArray = Array.thaw<Nat>(array);
    for (i in Iter.range(0, n - 2)) {
      for (j in Iter.range(0, n - 2)) {
        if (workingArray[j] > workingArray[j+1]) {
          var temp = workingArray[j];
          workingArray[j] := workingArray[i+1];
          workingArray[j+1] := temp;
        } 
      };
    };
    return Array.freeze<Nat>(workingArray);
  };

  let dayow : [Text] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  public func day_of_week(n : Nat) : async ?Text {
    if (n <= 8) {
      let a = dayow[n-1];
      return ?a;
    } else { return null; };
  };

  public func populate_array(array : [?Nat]) : async [Nat] {
    let populate = func (a : ?Nat) : Nat {
      switch(a) {
        case null {return 0};
        case (?a) {
          return a;
        };
      };
    };
    let b = Array.map<?Nat, Nat>(array, populate);
    return b;
  };

  public func squared_array(array : [Nat]) : async [Nat] {
    return (Array.map<Nat, Nat>(array, func (a : Nat) {return a**2;}))
  };

  public func increase_by_index(array : [Nat]) : async [Nat]{
    var index_count = 0;
    let translate = func (a : Nat) : Nat {
      var b : Nat = a + index_count;
      index_count += 1;
      return b;
    };
    return (Array.map<Nat, Nat>(array, translate));
  };

  public func duplicated_character(t : Text) : async Text {
    let n = t.size();
    if (n < 2) return t;
    let c : [Char] = Iter.toArray(t.chars());
    let sorted = Array.sort(c, Char.compare);
  
    for (char in Iter.range(1, n - 1)){
      if(c[char] == c[char - 1]) {return (Char.toText(c[char]))}
    };
    return t;
  };

  let f = func contain<A>(arr : [A], a : A, f : (A, A) -> Bool) : Bool {
      return Array.foldLeft<A, Bool>(arr, false, func(result, current) {
        if (f(current, a)) return true;
        return result;
      });
  };

  public func contain_test(arr : [Nat], a : Nat) : async Bool {
    try {
      return f<Nat>(arr, a, func(current, desired) {
        return current == desired;
      });
    } catch (e) {
      return false;
    };
  };

}; 