#include <iostream>

using namespace std;

int main()
{

	double ratios[9];
	char str[1024];

	for (int i = 0; i < 9; i++)
	{
		cin.getline(str, 1024);
		ratios[i]=atof(str);
	}

	int Diagnosis = 7;

	double h2 = ratios[0], ch4 = ratios[1], c2h6 = ratios[2],
		   c2h4 = ratios[3], c2h2 = ratios[4], co = ratios[5],
		   co2 = ratios[6], n2 = ratios[7], o2 = ratios[8];

	double R1 = (ch4 / (ch4 + c2h4 + c2h2)) * 100;
	double R2 = (c2h4 / (ch4 + c2h4 + c2h2)) * 100;
	double R3 = (c2h2 / (ch4 + c2h4 + c2h2)) * 100;

	if (R1 >= 98 && R2 <= 2 && R3 <= 2)
		Diagnosis = 1;
	else if (R3 <= 4 && R2 >= 20 && R2 <= 50 && R1 <= 80 && R1 >= 46)
		Diagnosis = 5;
	else if (R3 <= 4 && R2 <= 20 && R1 >= 76 && R1 <= 98)
		Diagnosis = 4;
	else if (R3 >= 0 && R2 <= 23)
		Diagnosis = 2;
	else if (R3 <= 15 && R2 >= 50 && R1 <= 50)
		Diagnosis = 6;
	else if  (R3 <= 79 && R3 >= 13 && R2 <= 77)
		Diagnosis = 3;
	else if (R3 <= 29 && R3 >= 4 && R2 <= 85)
		Diagnosis = 3;
	else
		Diagnosis = 7;


	cout << Diagnosis <<endl;
	
	return 0;
}