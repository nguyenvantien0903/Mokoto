import Array "mo:base/Array";
import Iter "mo:base/Iter";
actor {
  var counter : Nat = 0;
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
  public func add(n : Nat, m: Nat) : async Nat{
    return m+n;
  };
  public func square(n : Nat, m: Nat) : async Nat{
    return m*n;
  };
  public func days_to_second(n: Nat) : async Nat{
    return n*86400;
  };
  public func increment_counter(n : Nat) : async Nat{
    counter := counter + n;
    return counter;
  };
  public func clear_counter() : (){
    counter := 0;
  };
  public func divide(n : Nat, m : Nat) : async Bool{
    return n % m == 0;
  };
  public func is_even(n : Nat) : async Bool{
    return n % 2 == 0;
  };
  public func sum_of_array(a : [Nat]) : async Nat{
    var sum : Nat = 0;
    for(value in a.vals()){
      sum := sum + value;
    };
    return sum;
  };
  public func maximum(a : [Nat]) : async Nat{
    if(a.size() == 0) return 0;
    var max : Nat = a[0];
    for(value in a.vals()){
      if(max < value) max := value;
    };
    return max;
  };
  public func remove_from_array(a : [Nat], n : Nat) : async [Nat]{
    return Array.filter(a,func(i : Nat) : Bool { return i != n });
  };
  public func selection_sort(a : [Nat]) : async [Nat]{
    let b = Array.thaw<Nat>(a);
    for(i in (Iter.range(0, b.size()-1))){
      var min = i;
      for(j in (Iter.range(i+1, b.size()-1))){
        if(b[j] < b[min]) min := j;
      };
      if(min != i){
        var temp = b[i];
        b[i] := b[min];
        b[min] := temp;
      };
    };
    return Array.freeze<Nat>(b);
  };
};
