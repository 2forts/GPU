__global__ void EuclideanDistance(double *data, double *D, int dataRows, int dataCols){
	unsigned int ix = blockIdx.x * blockDim.x + threadIdx.x;
	int i = ix / (dataRows + 1), j = ix % (dataRows + 1);
	unsigned int idx;

	if (j > i) i = dataRows - i - 1, j = dataRows - j;
	idx = (i * dataRows + j);

	if (idx < (dataRows * (dataRows + 1) / 2))
	{
		double resta;
		double suma = 0;
		int k, m;

		for (k = 0 ; k < dataCols; k++) {
				resta = data[i * dataRows + k] - data[j * dataRows + k];
				suma += resta * resta;
		}
					
		suma = sqrt(suma);

		D[i * dataRows + j] = suma;
		D[j * dataRows + i] = suma;
	}
}