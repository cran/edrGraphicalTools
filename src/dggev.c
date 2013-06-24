#include <string.h> /* strcpy() */
#include <stdlib.h> /* free() */
#include <R.h>
#include <Rdefines.h>
#include <R_ext/Parse.h>
#include <R_ext/Lapack.h>

//Fonction pour pouvoir exécuter la fonction "dggev" de la bibliothèque Fortran "LAPACK".
//Cette fonction permet d'utiliser l'algorithme QZ pour pouvoir calculer les 
//éléments propres généralisés de deux matrices A et B

//Raphaël Coudret, 6 juin 2013

//void dggev(char *jobvl, char *jobvr, int *n, double * a, int *lda, double *b, int *ldb,
//	double *alphar, double *alphai, double *beta, double *vl, int *ldvl, double *vr, 
//	int *ldvr, double *work, int *lwork, int *info) {
SEXP Cdggev(SEXP AR, SEXP BR, SEXP jobvlR, SEXP jobvrR) {
	SEXP resultatR, betaR, alpharR, alphaiR, vlR, vrR, nomsResR, dimAR;
	double *beta, *A, *B, *A2, *B2, *alphar, *alphai, *vl, *vr, *work;
	int *p, *lwork, *info, tailleList, i;
	char *jobvl, *jobvr;

	/* Teste la nature des variables */
	if (!isNumeric(AR)) {
		error("Le premier argument de la fonction 'dggev' doit être une matrice de réels.");
	}	
	if (!isNumeric(BR)) {
		error("Le second argument de la fonction 'dggev' doit être une matrice de réels.");
	}	
	if (!isLogical(jobvlR)) {
		error("Le troisième argument de la fonction 'dggev' doit être un booléen.");
	}
	if (!isLogical(jobvrR)) {
		error("Le quatrième argument de la fonction 'dggev' doit être un booléen.");
	}

	/* Transformation des variables R en variables C */
	jobvl = malloc(sizeof(char) * 2);
	jobvr = malloc(sizeof(char) * 2);
	if (*(LOGICAL(jobvlR))) {
		strcpy(jobvl,"V");
	} else {
		strcpy(jobvl,"N");
	}
	if (*(LOGICAL(jobvrR))) {
		strcpy(jobvr,"V");
	} else {
		strcpy(jobvr,"N");
	}
	PROTECT(dimAR = GET_DIM(AR));
	p = INTEGER(dimAR);
	A = REAL(AR);
	B = REAL(BR);

	/* Initialisation des autres variables */	
	lwork = malloc(sizeof(int));
	*lwork = (*p) * 8;
	alphar = malloc(sizeof(double) * (*p));	
	alphai = malloc(sizeof(double) * (*p));	
	beta = malloc(sizeof(double) * (*p));
	vl = malloc(sizeof(double) * (*p) * (*p));
	vr = malloc(sizeof(double) * (*p) * (*p));
	work = malloc(sizeof(double) * (*lwork));
	info = malloc(sizeof(int));
	A2 = malloc(sizeof(double) * (*p) * (*p));
	B2 = malloc(sizeof(double) * (*p) * (*p));

	/* Duplication de A et B pour les protéger contre une écriture */
	for (i=0;i< (*p) * (*p);i++) {
		A2[i] = A[i];
		B2[i] = B[i];
	}
		
	F77_NAME(dggev)( jobvl, jobvr, p, A2, p, B2, p, alphar, alphai, beta, vl, p, vr,
		p, work, lwork, info);
	//Rprintf("beta 1 = %f \n", beta[0]);
	//Rprintf("beta 2 = %f \n", beta[1]);
	//Rprintf("alpha 1 = %f \n", alphar[0]);
	//Rprintf("alpha 2 = %f \n", alphar[1]);

	/* Transformation des variables C en variables R */
	tailleList = 3 + *(LOGICAL(jobvlR)) + *(LOGICAL(jobvrR));
	//Rprintf("tailleList = %d",tailleList);
	PROTECT(resultatR = allocVector(VECSXP, tailleList));
	PROTECT(alpharR = allocVector(REALSXP, *p));
	PROTECT(alphaiR = allocVector(REALSXP, *p));
	PROTECT(betaR = allocVector(REALSXP, *p));
	for (i=0; i<(*p); i++) {
		REAL(alpharR)[i] = alphar[i];
		REAL(alphaiR)[i] = alphai[i];
		REAL(betaR)[i] = beta[i];
	}
	if (*(LOGICAL(jobvlR))) {
		PROTECT(vlR = allocVector(REALSXP, (*p) * (*p)));
		for (i=0; i<(*p) * (*p); i++) {
			REAL(vlR)[i] = vl[i];
	}	}
	if (*(LOGICAL(jobvrR))) {
		PROTECT(vrR = allocVector(REALSXP, (*p) * (*p)));
		for (i=0; i<(*p) * (*p); i++) {
			REAL(vrR)[i] = vr[i];
	}	}
	PROTECT(nomsResR = allocVector(STRSXP,tailleList));
	SET_STRING_ELT(nomsResR, 0, mkChar("alphar"));
	SET_STRING_ELT(nomsResR, 1, mkChar("alphai"));
	SET_STRING_ELT(nomsResR, 2, mkChar("beta"));
	SET_VECTOR_ELT(resultatR, 0, alpharR);
	SET_VECTOR_ELT(resultatR, 1, alphaiR);
	SET_VECTOR_ELT(resultatR, 2, betaR);
	if (*(LOGICAL(jobvlR))) {
		SET_STRING_ELT(nomsResR, 3, mkChar("vl"));
		SET_VECTOR_ELT(resultatR, 3, vlR);
		if (*(LOGICAL(jobvrR))) {
			SET_STRING_ELT(nomsResR, 4, mkChar("vr"));		
			SET_VECTOR_ELT(resultatR, 4, vrR);					
		}
	} else {
		if (*(LOGICAL(jobvrR))) {
			SET_STRING_ELT(nomsResR, 3, mkChar("vr"));
			SET_VECTOR_ELT(resultatR, 3, vrR);			
	}	}
	SET_NAMES(resultatR, nomsResR);

	/* Libération de la mémoire */
	free(jobvl);
	free(jobvr);
	free(lwork);
	free(alphar);
	free(alphai);
	free(beta);
	free(vl);
	free(vr);
	free(work);
	free(info);
	free(A2);
	free(B2);
	UNPROTECT(tailleList+3);
	return resultatR;

} 


