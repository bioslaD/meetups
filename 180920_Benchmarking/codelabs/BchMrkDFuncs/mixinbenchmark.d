import std.stdio;
import std.conv : to;
import std.datetime.stopwatch: benchmark, Duration;

mixin template kroundup32(T) {
  // string mstr = "String from template";
  void kroundup32(ref T x){
    // pragma(inline, true);
    --x;
    x|=x>>1;
    x|=x>>2;
    x|=x>>4;
    x|=x>>8;
    x|=x>>16;
    ++x;
    // writeln("X:", x, " v1: ", v1);

  }

}

void mxroundup32(T)(ref T x){
  mixin ("--x;x|=x>>1;x|=x>>2;x|=x>>4;x|=x>>8;x|=x>>16;++x;");


}
// String mixin version by Ali Çehreli
// Discussion: http://forum.dlang.org/post/ocbl17$14vl$1@digitalmars.com
string roundUp(alias x)()
  if (is (typeof(x) == uint)) {
    import std.string : format;
    return format(q{
        --%1$s;
        %1$s |= %1$s >>  1;
        %1$s |= %1$s >>  2;
        %1$s |= %1$s >>  4;
        %1$s |= %1$s >>  8;
        %1$s |= %1$s >> 16;
        ++%1$s;

      }, x.stringof);

  }

unittest{
  int n1 = 31;
  int n2 = 32;
  writeln("Testing kroundup32");
  mixin kroundup32!(int, 3);
  kroundup32(n1);
  assert(n1 == 32);
  kroundup32(n2);
  assert(n2 == 32);
int num = 31;
  // int mstr = 1234;
  writeln("Before: ", num); // 31
  mixin kroundup32!(int);
kroundup32(num);
  writeln("After: ", num);   //32
  // writeln("Mstr: ", mstr);
  num = 31;
  mxroundup32!int(num);
  writeln("Num 31 ->", num);
  assert(num == 32);
  num = 33;
  mxroundup32!int(num);
  writeln("Num 33 ->", num);
assert(num == 64);
}

void testMixinTemplate(){
  uint n1 = 31;
  mixin kroundup32!(uint);
  kroundup32(n1);


}

void testMixinFunction(){
  uint n2 = 31;
  mxroundup32!uint(n2);

}
void testStringMixin(){
  uint n3 = 31;
  roundUp!(n3);

}
int main(){
  writeln("Bench marking...");
  auto r = benchmark!(testMixinTemplate, testMixinFunction, testStringMixin)(10_000);
  auto f0 = to!Duration(r[0]);
  auto f1 = to!Duration(r[1]);
  auto f2 = to!Duration(r[2]);
  writeln("Mixin Teplate: ", f0, "\nMixin Function: ", f1, "\nMixin string: ", f2);
  return 0;

}
