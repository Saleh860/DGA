#include <iostream>
#include <fstream>

using namespace std;

int main()
{

	double ratios[9];
	char str[1024];

	ofstream log("log.txt");

	for (int i = 0; i < 9; i++)
	{
		cin.getline(str, 1024);
		ratios[i]=atof(str);
		log << ratios[i]<<endl;
	}

	int diagnosis = 7;

	cout << diagnosis <<endl;

	log << "======"  << endl;
	log << diagnosis << endl;
	
	return 0;
}