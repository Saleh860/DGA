#include <iostream>
#include <fstream>

using namespace std;

void main()
{
	float ratios[9];
	char str[256];
	ifstream in("ratios.txt”);
	for (int i = 0; i < 9; i++)
	{
		in.getline(str, 256);
		ratios[i]=atoi(str);
	}
	ofstream out("diagnosis.txt”);
	out << 1;
}