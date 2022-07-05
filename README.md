# Kalman Filter  Two dimension Example：

## Plant：

$$
\left[ \begin{array}{c}
	x_{1,\mathrm{k}}\\
	x_{2,\mathrm{k}}\\
\end{array} \right] =\mathrm{A}\left[ \begin{array}{c}
	x_{1,\mathrm{k}-1}\\
	x_{2,\mathrm{k}-1}\\
\end{array} \right] +\left[ \begin{array}{c}
	w_{1,\mathrm{k}-1}\\
	w_{2,\mathrm{k}-1}\\
\end{array} \right] \,\,p\left( w \right) \sim N\left( 0,Q \right) 
\\
\left[ \begin{array}{c}
	z_{1,\mathrm{k}}\\
	z_{2,\mathrm{k}}\\
\end{array} \right] =H\left[ \begin{array}{c}
	x_{1,\mathrm{k}}\\
	x_{2,\mathrm{k}}\\
\end{array} \right] +\left[ \begin{array}{c}
	v_{1,\mathrm{k}}\\
	v_{2,\mathrm{k}}\\
\end{array} \right] \,\,      p\left( v \right) \sim N\left( 0,R \right)
$$

## Optimal Recursive Data Processing Algorithm （Kalman Filter Algorithm）

### Prediction：

$$
\left[ \begin{array}{c}
	\hat{x}_{1,k}^{-}\\
	\hat{x}_{2,k}^{-}\\
\end{array} \right] =\mathrm{A}\left[ \begin{array}{c}
	\hat{x}_{1,\mathrm{k}-1}\\
	\hat{x}_{2,\mathrm{k}-1}\\
\end{array} \right] 
\\
P_{k}^{-}=\mathrm{A}P_{\mathrm{k}-1}\mathrm{A}^{\mathrm{T}}+\mathrm{Q}
$$

### Correction

$$
K_{\mathrm{k}}=P_{k}^{-}H^T\left( HP_{k-1}^{-}H^T+R \right) ^{-1}
\\
\mathrm{\hat{X}}_{\mathrm{k}}=\mathrm{\hat{X}}_{k}^{-}+K_{\mathrm{k}}\left( \mathrm{Z}_{\mathrm{k}}-H\mathrm{\hat{X}}_{k}^{-} \right) 
\\
P_{\mathrm{k}}=\left( 1-K_{\mathrm{k}}H \right) P_{k}^{-}
$$