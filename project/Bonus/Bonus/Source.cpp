#ifndef __USE_SQUARE_BRACKETS_FOR_ELEMENT_ACCESS_OPERATOR
#define __USE_SQUARE_BRACKETS_FOR_ELEMENT_ACCESS_OPERATOR 
#endif//!__USE_SQUARE_BRACKETS_FOR_ELEMENT_ACCESS_OPERATOR

#include <iostream>
#include <fstream>
#include <math.h>
#include <chrono> 
#include "fft.h"
#include "fft_settings.h"
#include "Header.h"

using namespace simple_fft;
using std::size_t;

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


int main()
{
	auto start = high_resolution_clock::now();//measure time

	const char* file = "Tarrat_Juan_orig.wav";

	FILE* inFile = fopen(file, "rb");

	//read header
	Header header;
	int headerSize = sizeof(header);
	fread(&header, headerSize, 1, inFile);
	const int dataSize = header.subChunk2Size * 8 / header.bitsPerSample;
	fourBytes sampleRate = header.sampleRate; // get sample rate
	const int duration = header.subChunk2Size / header.numChannels * 8 / header.bitsPerSample / header.sampleRate;

	const char* err;

	typedef real_type* RealArray1D;
	typedef complex_type* ComplexArray1D;

	bool fftArr;

	const size_t fftCoef = 1024;
	const size_t inCoef = 2048;
	const size_t shiftInteger = 1536;

	RealArray1D inputVals = new real_type[inCoef];
	RealArray1D windowVals = new real_type[inCoef];
	ComplexArray1D fftVals = new complex_type[fftCoef];	

	double fsum = 0; //minimum
	double fmax = 0;
	int fIndex;
	
	//process second by second
	for (int j = 0; j < duration; j++)
	{
		int t = 0;
		//read all the second in inputVals array
		
		for (int i = 0; i < 2 * inCoef; i++)
		{
			if (i % 2 == 0)
			{
				//read just one channel
				fread(&inputVals[t], sizeof(twoBytes), 1, inFile);
				t++;
			}
		}
		
		for (int u = 0; u < 14; u++) //windows for each second
		{
			
			for (int i = 0; i < inCoef; i++)
			{
				windowVals[i] = HammingVals[i] * inputVals[i];
			}

			fftArr = FFT(windowVals, fftVals, fftCoef, err);

			double val = sqrt((fftVals[0].imag() * fftVals[0].imag()) + (fftVals[0].real() * fftVals[0].real())) / 1024;

			for (int i = 0; i < fftCoef; i++)
			{
				val = sqrt((fftVals[i].imag() * fftVals[i].imag()) + (fftVals[i].real() * fftVals[i].real())) / 1024;
				
				if (fmax < val)
				{
					fmax = val;
					fIndex = i;
				}
			}
			
			fmax = fIndex * double((sampleRate / fftCoef));
			fsum += fmax;

			//shift values
			for (int i = 0; i < fftCoef/2; i++)
			{
				inputVals[i] = inputVals[i+fftCoef/2];
			}
			//read new values for window
			t = fftCoef / 2;
			for (int i = 0; i < 2*shiftInteger; i++)
			{
				if (i % 2 == 0)
				{
					//read just one channel
					fread(&inputVals[t], sizeof(twoBytes), 1, inFile);
					t++;
				}
			}
		}
		//fmax = fIndex * sampleRate / fftCoef;
		for (int i = 0; i < inCoef; i++)
		{
			inputVals[i] = 0;
			windowVals[i] = 0;
		}

		
		cout << "t = " << j << "s " << "favg = " << fsum << endl;
		fmax = 0;
		fsum = 0;

	}

	return 0;

}