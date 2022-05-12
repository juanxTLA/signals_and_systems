#include <iostream>
#include <fstream>
#include <math.h>
#include <chrono> 
#include "filterCoef.h"
#include "filterCoef2.h"
#include <vector>


using namespace std::chrono;
using namespace std;

typedef int16_t twoBytes;
typedef int32_t fourBytes;

//typedef for the header
typedef struct HEADER {
	//RIFF descriptor
	fourBytes chunkId;
	fourBytes chunkSize;
	fourBytes format;
	//fmt section
	fourBytes subChunk1Id;
	fourBytes subChunk1Size;
	twoBytes audioFormat;
	twoBytes numChannels;
	fourBytes sampleRate;
	fourBytes byteRate;
	twoBytes blockAlign;
	twoBytes bitsPerSample;
	//data subchunk
	fourBytes subChunk2Id;
	fourBytes subChunk2Size;
	//data comes after this
}Header;

void xiir_filter(double* x, double* y, twoBytes sample, double* B, int size);

int main(int argc, char* argv[]) //command line arguments are set in properties of the project under 'debugging'
{
	//NUMLEN is the same for both filters since the only difference are the coefficents due to the different frequencies the filers are designed for
	auto start = high_resolution_clock::now();//measure time

	const char* file = argv[1];
	

	FILE* inFile = fopen(file, "rb");

	//read header
	Header header;
	int headerSize = sizeof(header);
	fread(&header, headerSize, 1, inFile);
	const int dataSize = header.subChunk2Size*8/header.bitsPerSample;
	fourBytes sampleRate = header.sampleRate; // get sample rate

	//choose filter to use
	//NUMLEN is the same for both filters since the only difference are the coefficents due to the different frequencies the filers are designed for
	
	int size;
	//prepare variables to store and manipulate data
	twoBytes* audioData = new twoBytes[dataSize];
	twoBytes* outputData = new twoBytes[dataSize];

	
	//open output file
	FILE* outFile = fopen(argv[2], "wb");//output file is noise.wav
	fwrite(&header, headerSize, 1, outFile);

	int aMax = pow(2, header.bitsPerSample - 1) - 1;// data is signed int
	twoBytes maxVal = 0;

	if (sampleRate == 22050)
	{
		//B.resize(NUMLEN0);
		double* B = new double [NUMLEN0];
		size = NUMLEN0;
		for (int i = 0; i < NUMLEN0; i++)  B[i] = B0[i];

		double* xLeft = new double[size];
		double* yLeft = new double[size];
		double* xRight = new double[size];
		double* yRight = new double[size];

		//intialize arrays to 0
		for (int i = 0; i < size; i++) xLeft[i] = yLeft[i] = xRight[i] = yRight[i] = 0;


		for (int i = 0; i < dataSize; i++)
		{
			fread(&audioData[i], sizeof(twoBytes), 1, inFile);

			if (i % 2 == 0)
			{
				xiir_filter(xLeft, yLeft, audioData[i], B, size);
				outputData[i] = (twoBytes)yLeft[0];
			}
			else
			{
				xiir_filter(xRight, yRight, audioData[i], B, size);
				outputData[i] = (twoBytes)yRight[0];
			}


			//if (outputData[i] > aMax) outputData[i] = aMax; //account for overflow
			fwrite(&outputData[i], sizeof(twoBytes), 1, outFile);
		}

	}
	else if (sampleRate == 11025)
	{
		//B.resize(NUMLEN1);
		size = NUMLEN1;
		double* B = new double[NUMLEN1];
		for (int i = 0; i < NUMLEN1; i++)  B[i] = B1[i];

		double* xLeft = new double[size];
		double* yLeft = new double[size];
		double* xRight = new double[size];
		double* yRight = new double[size];

		//intialize arrays to 0
		for (int i = 0; i < size; i++) xLeft[i] = yLeft[i] = xRight[i] = yRight[i] = 0;


		for (int i = 0; i < dataSize; i++)
		{
			fread(&audioData[i], sizeof(twoBytes), 1, inFile);

			if (i % 2 == 0)
			{
				xiir_filter(xLeft, yLeft, audioData[i], B, size);
				outputData[i] = (twoBytes)yLeft[0];
			}
			else
			{
				xiir_filter(xRight, yRight, audioData[i], B, size);
				outputData[i] = (twoBytes)yRight[0];
			}


			//if (outputData[i] > aMax) outputData[i] = aMax; //account for overflow
			fwrite(&outputData[i], sizeof(twoBytes), 1, outFile);
		}
	}
	else cout << "This program can´t filter your audio, sorry." << endl;

	auto stop = high_resolution_clock::now();
	auto exec = duration_cast<milliseconds>(stop - start);

	cout << "Execution time: " << exec.count() << "ms" << endl;

	return 0;
}

void xiir_filter(double* x, double* y, twoBytes sample, double* B, int size)
{
	double templ;

	for (int i = size - 1; i > 0; i--)
	{
		x[i] = x[i - 1];
		y[i] = y[i - 1];
	}

	x[0] = sample;
	
	templ = 0;
	for (int i = 0; i < size; i++)
	{
		templ += x[i] * B[i];
	}

	y[0] = templ;

}