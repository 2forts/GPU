__global__ void GuttmanPart1(double *D, double *projD, double *GT_B, int dataRows){
		unsigned int ix = blockIdx.x * blockDim.x + threadIdx.x;
        int i = ix / (dataRows + 1), j = ix % (dataRows + 1);
        unsigned int idx;

        if (j > i) i = dataRows - i - 1, j = dataRows - j;
        idx = (i * dataRows + j);

		if (idx < (dataRows * (dataRows + 1) / 2)){	
			if (i != j){
				unsigned int idy = j * dataRows + i;
				//non-diagonal elements %
				if (projD[idx] != 0.0 ){
					GT_B[idx] = -D[idx] / projD[idx];
					GT_B[idy] = GT_B[idx];
				}else{
					GT_B[idx] = 0.0;
					GT_B[idy] = GT_B[idx];
				}
			}
		}
	}
}

__global__ void GuttmanPart2(double *GT_B, int dataRows){
		unsigned int ix = blockIdx.x * blockDim.x + threadIdx.x;

		if (ix < dataRows){	
			// diagonal elements %
			GT_B[idx] = 0.0;

			for (k = 0; k < dataRows; k++){
				GT_B[idx] += GT_B[ix * dataRows + k];
			}
		}
	}
}