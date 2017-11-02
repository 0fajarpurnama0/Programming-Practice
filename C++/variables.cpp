#include <iostream>
#include <string>

int main() {
 float a,b,c,d,e,f = 0; 
 std::string firstname, lastname, name;
 firstname = "Fajar"; lastname = "Purnama";
 std::cout << "Hello my name is " << firstname << " " << lastname << std::endl;
 std::cout << "What's your name: "; std::cin >> name;
 std::cout << "Ohh hello " << name << std::endl;
 std::cout << "Enter 1st number: "; std::cin >> a;
 std::cout << "Enter 2nd number: "; std::cin >> b;
 c = a + b;
 std::cout << a << "+" << b << "=" << c << std::endl;
 d = a - b;
 std::cout << a << "-" << b << "=" << d << std::endl;
 e = a * b;
 std::cout << a << "*" << b << "=" << e << std::endl;
 f = a/b;
 std::cout << a << "/" << b << "=" << f << std::endl;
 return 0;
}
