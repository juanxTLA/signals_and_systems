#include <iostream>
#include <fstream>
#include <math.h>
#include <chrono> 
#include "filterCoef.h"


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

void xiir_filter(int* x, int* y, int sample);

int main(int argc, char* argv[]) //command line arguments are set in properties of the project under 'debugging'
{
	
	auto start = high_resolution_clock::now();//measure time

	const char* file = argv[1];
	//ofstream summary;
	//summary.open("Tarrat_Juan_sum.txt");

	FILE* inFile = fopen(file, "rb");

	//read header
	Header header;
	int headerSize = sizeof(header);
	fread(&header, headerSize, 1, inFile);
	const int dataSize = header.subChunk2Size*8/header.bitsPerSample;
	fourBytes sampleRate = header.sampleRate; //fixed duration
	
	//prepare variables to store and manipulate data
	twoBytes* audioData = new twoBytes[dataSize];
	twoBytes* outputData = new twoBytes[dataSize];

	//open output file
	FILE* outFile = fopen(argv[2], "wb");//output file is noise.wav
	fwrite(&header, headerSize, 1, outFile);

	int aMax = pow(2, header.bitsPerSample - 1) - 1;// data is signed int
	twoBytes maxVal = 0;
	short channel;



	for (int i = 0; i < dataSize; i++)
	{
		int rn = rand() % (aMax + 1); //  random number between 0 and A max
		fread(&audioData[i], sizeof(twoBytes), 1, inFile);
		if (abs(audioData[i]) > maxVal)
		{
			maxVal = abs(audioData[i]);
			channel = i % 2;
		}
		outputData[i] = audioData[i] + 0.02 * rn - 0.01 * aMax;
		if (outputData[i] > aMax) outputData[i] = aMax; //account for overflow
		fwrite(&outputData[i], sizeof(twoBytes), 1, outFile);
	}

	//print header info
	/*
	summary << "-----------------------------" << endl;
	summary << "Summary" << endl;
	summary << "-----------------------------" << endl;
	summary << "Filename: " << argv[1] << endl;
	summary << "-----------------------------" << endl;
	summary << "Sampling Freq: " << header.sampleRate << endl;
	summary << "Number of channels: " << header.numChannels << endl;
	summary << "Bits per Sample: " << header.bitsPerSample << endl;
	summary << "File duration: " << duration << "s" << endl;
	summary << "-----------------------------" << endl;
	

	
	
	

	if (channel == 0) channel = 2;

	summary << "Maximum value (absolute value): " << maxVal << endl;
	summary << "Channel: " << channel << endl;
		
	
	auto stop = high_resolution_clock::now();//measure time 
	auto exec = duration_cast<milliseconds>(stop - start);
	summary << "Program duration: " << exec.count() << "ms" << endl;
	summary << "-----------------------------" << endl;
	summary.close();
	*/


	return 0;
}

void xiir_filter(int* x, int* y, int sample)
{
	long templ;

	for (int i = NUMLEN - 1; i > 0; i--)
	{
		x[i] = x[i - 1];
		y[i] = y[i - 1];
	}

	x[0] = sample;
	
	templ = 0;
	for (int i = 0; i < NUMLEN; i++)
	{
		templ += x[i] * B[i];
	}

	y[0] = (int)templ;


}