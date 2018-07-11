/*
 * linreg.h
 *
 *  Created on: Jul 11, 2018
 *      Author: fabio
 */

#ifndef SRC_LINREG_H_
#define SRC_LINREG_H_

void print_model(int T[], int n);
unsigned int has_converged(int Tnew[], int T[], int n, int threshold);


#endif /* SRC_LINREG_H_ */
