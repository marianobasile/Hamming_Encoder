#include <iostream>
#include <string>
using namespace std;
string word;

void askForInputData () {
	bool error = false;
	do {
		if(error)
		cout<<"ERROR: DIMENSIONE ERRATA!!RIPROVARE"<<endl;

		cout<<"Inserire la parola da codificare (11 bit): ";
		cin>>word;

		if(word.size() != 11)
			error = true;

	} while(word.size() != 11);
}

bool checkInputData() {
	bool error = false;
	for(unsigned int i=0; i<word.size(); i++)
		if( (word[i] != '0' && word[i] != '1') ) {
			cout<<"ERROR:BIT NON VALIDO ALL'INDICE: "<<"["<<i<<"]"<<endl;
			error = true;
			break;
		}

	if(error)
		return true;

	return false;
}

int main() {
	
	cout<<"\t\t\t======= HAMMING ENCODER ======="<<endl<<endl;
	
	askForInputData();

	while(checkInputData())
		askForInputData();

	//Determining parity bit
	unsigned int P1,P2,P4,P8,PO;

	P1 = word[0] ^ word[2] ^ word[4] ^ word[6] ^ word[7] ^ word[9] ^ word[10];
	P2 = word[0] ^ word[1] ^ word[4] ^ word[5] ^ word[7] ^ word[8] ^ word[10];
	P4 = word[0] ^ word[1] ^ word[2] ^ word[3] ^ word[7] ^ word[8] ^ word[9];
	P8 = word[0] ^ word[1] ^ word[2] ^ word[3] ^ word[4] ^ word[5] ^ word[6];

	PO = P1 ^ P2 ^ word[0] ^ P4 ^ word[1] ^ word[2] ^ word[3] ^ P8 ^ word[4] ^ word[5] ^ word[6] ^ word[7] ^ word[8] ^ word[9] ^ word[10];

	//Determining CODEWORD
	char codeword[17] = { (char)PO, word[0], word[1], word[2], word[3], word[4], word[5], word[6], (char)P8, word[7], word[8], word[9], (char)P4, word[10], (char)P2, (char)P1, '\0'};

	cout<<"CODEWORD DA TRASMETTERE: "<<codeword<<endl;

	return 0;
}